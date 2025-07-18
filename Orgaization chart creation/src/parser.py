import os
import re
from typing import Dict, List, Tuple, Set
import networkx as nx
import openai

class TextParser:
    """Parser pour analyser le texte et générer un organigramme"""
    
    def __init__(self):
        pass
    
    def parse_to_mermaid_llm(self, text: str) -> str:
        """
        Utilise Azure OpenAI pour générer la syntaxe Mermaid à partir du texte.
        """
        api_key = "b32e8fa36b8d4efd81721f85bfca4f54"
        endpoint = "https://aoai-sandbox-sweden.openai.azure.com/"
        deployment = "gpt4o"

        if not all([api_key, endpoint, deployment]):
            raise ValueError("Variables d'environnement Azure OpenAI manquantes.")

        client = openai.AzureOpenAI(
            api_key=api_key,
            api_version="2023-05-15",
            azure_endpoint=endpoint
        )

        prompt = (
            "Tu es un assistant qui transforme une description d'organisation en syntaxe Mermaid pour un organigramme.\n"
            "Pour chaque département ou équipe, utilise un sous-graphe (subgraph) Mermaid.\n"
            "Exemple de sortie attendue :\n"
            "graph TD\n"
            "    subgraph IT\n"
            "        Bob(\"Bob<br/>Directeur Technique\")\n"
            "        David(\"David<br/>Développeur\")\n"
            "    end\n"
            "    subgraph Marketing\n"
            "        Claire(\"Claire<br/>Directrice Marketing\")\n"
            "        Emma(\"Emma<br/>Designer\")\n"
            "    end\n"
            "    Alice(\"Alice<br/>PDG\")\n"
            "    Alice --> Bob\n"
            "    Alice --> Claire\n"
            "    Bob --> David\n"
            "    Claire --> Emma\n"
            "Voici la description :\n"
            f"{text}\n"
            "Donne uniquement la syntaxe Mermaid, avec les subgraphs pour chaque département ou équipe, sans explication."
        )

        response = client.chat.completions.create(
            model=deployment,
            messages=[{"role": "user", "content": prompt}],
            temperature=0,
            max_tokens=800
        )
        mermaid_code = response.choices[0].message.content.strip()
        mermaid_code = mermaid_code[3:-3]
        return mermaid_code

    def parse_to_mermaid(self, text: str) -> str:
        # Utilise le LLM Azure OpenAI par défaut
        return self.parse_to_mermaid_llm(text)
        # Pour revenir au parsing local, commente la ligne ci-dessus et décommente celle-ci :
        # return self._simple_parse_example(text) 