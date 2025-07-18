from flask import Flask, render_template, request, jsonify
try:
    from .parser import TextParser  # Import relatif (mode package)
except ImportError:
    from parser import TextParser   # Import direct (mode script)
import os

app = Flask(__name__)
parser = TextParser()

@app.route('/')
def index():
    """Page principale avec l'interface de saisie de texte"""
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate_organigram():
    """Génère l'organigramme à partir du texte fourni"""
    try:
        data = request.get_json()
        text = data.get('text', '')
        
        if not text.strip():
            return jsonify({'error': 'Le texte ne peut pas être vide'}), 400
        
        # Parser le texte et générer la syntaxe Mermaid
        mermaid_code = parser.parse_to_mermaid(text)
        
        return jsonify({
            'success': True,
            'mermaid_code': mermaid_code,
            'message': 'Organigramme généré avec succès'
        })
        
    except Exception as e:
        return jsonify({'error': f'Erreur lors de la génération: {str(e)}'}), 500

@app.route('/health')
def health():
    """Endpoint de santé pour vérifier que l'application fonctionne"""
    return jsonify({'status': 'ok', 'message': 'Application organigramme opérationnelle'})

def main():
    """Point d'entrée principal de l'application"""
    port = int(os.environ.get('PORT', 8000))
    debug = os.environ.get('FLASK_DEBUG', 'False').lower() == 'true'
    
    print(f"🚀 Démarrage de l'application organigramme sur le port {port}")
    print(f"📊 Interface disponible sur: http://localhost:{port}")
    
    app.run(host='0.0.0.0', port=port, debug=debug)

if __name__ == '__main__':
    main() 