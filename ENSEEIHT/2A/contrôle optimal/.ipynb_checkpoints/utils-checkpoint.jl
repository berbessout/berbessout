




<!DOCTYPE html>
<html class="gl-light ui-neutral with-header with-top-bar " lang="fr">
<head prefix="og: http://ogp.me/ns#">
<meta charset="utf-8">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta content="width=device-width, initial-scale=1" name="viewport">
<title>tp/utils.jl · master · toc / Etudiants N7 / Contrôle optimal · GitLab</title>
<script>
//<![CDATA[
window.gon={};gon.math_rendering_limits_enabled=true;gon.features={"explainCodeChat":false};
//]]>
</script>

<script>
//<![CDATA[
var gl = window.gl || {};
gl.startup_calls = null;
gl.startup_graphql_calls = [{"query":"query getBlobInfo(\n  $projectPath: ID!\n  $filePath: String!\n  $ref: String!\n  $refType: RefType\n  $shouldFetchRawText: Boolean!\n) {\n  project(fullPath: $projectPath) {\n    __typename\n    id\n    repository {\n      __typename\n      empty\n      blobs(paths: [$filePath], ref: $ref, refType: $refType) {\n        __typename\n        nodes {\n          __typename\n          id\n          webPath\n          name\n          size\n          rawSize\n          rawTextBlob @include(if: $shouldFetchRawText)\n          fileType\n          language\n          path\n          blamePath\n          editBlobPath\n          gitpodBlobUrl\n          ideEditPath\n          forkAndEditPath\n          ideForkAndEditPath\n          codeNavigationPath\n          projectBlobPathRoot\n          forkAndViewPath\n          environmentFormattedExternalUrl\n          environmentExternalUrlForRouteMap\n          canModifyBlob\n          canCurrentUserPushToBranch\n          archived\n          storedExternally\n          externalStorage\n          externalStorageUrl\n          rawPath\n          replacePath\n          pipelineEditorPath\n          simpleViewer {\n            fileType\n            tooLarge\n            type\n            renderError\n          }\n          richViewer {\n            fileType\n            tooLarge\n            type\n            renderError\n          }\n        }\n      }\n    }\n  }\n}\n","variables":{"projectPath":"toc/etu-n7/controle-optimal","ref":"master","refType":"HEADS","filePath":"tp/utils.jl","shouldFetchRawText":true}}];

if (gl.startup_calls && window.fetch) {
  Object.keys(gl.startup_calls).forEach(apiCall => {
   gl.startup_calls[apiCall] = {
      fetchCall: fetch(apiCall, {
        // Emulate XHR for Rails AJAX request checks
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        },
        // fetch won’t send cookies in older browsers, unless you set the credentials init option.
        // We set to `same-origin` which is default value in modern browsers.
        // See https://github.com/whatwg/fetch/pull/585 for more information.
        credentials: 'same-origin'
      })
    };
  });
}
if (gl.startup_graphql_calls && window.fetch) {
  const headers = {"X-CSRF-Token":"Fjr8lo87izsZkoL-ujybOhZRYIYfLoG_uNYZPTVJAfBPlQzAy0PTpDxlDcqgEzS7rOO4E4eL7BlbBtbj2--Emw","x-gitlab-feature-category":"source_code_management"};
  const url = `https://gitlab.irit.fr/api/graphql`

  const opts = {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...headers,
    }
  };

  gl.startup_graphql_calls = gl.startup_graphql_calls.map(call => ({
    ...call,
    fetchCall: fetch(url, {
      ...opts,
      credentials: 'same-origin',
      body: JSON.stringify(call)
    })
  }))
}


//]]>
</script>

<link rel="prefetch" href="/assets/webpack/monaco.85d6b268.chunk.js">

<link rel="stylesheet" href="/assets/application-539db0d62ee9e10949bac79127c082aaa0e8d001ddda9467cd8a1d05928a9b8b.css" media="all" />
<link rel="stylesheet" href="/assets/page_bundles/tree-4d25647d03722854e14fe89644330ef783d9e6e79f75ae79c5755c11825ddfc8.css" media="all" /><link rel="stylesheet" href="/assets/page_bundles/projects-5b110dab09b20b77c1dc0d46d525a29cff171240bb81bd04b42a842b8d3d93ce.css" media="all" /><link rel="stylesheet" href="/assets/page_bundles/commit_description-b1dab9b10010cbb9c3738689b18ce46a4f58b98a8d483226fdff8a776a45caf0.css" media="all" />
<link rel="stylesheet" href="/assets/application_utilities-4ce46b0d1744a75b5e0b7104e935413dc41b09b34002dc2832a687dd8e7f0569.css" media="all" />
<link rel="stylesheet" href="/assets/application_utilities_to_be_replaced-3d8b0b41666e50fa9df36dbce4b6771c6886c20fbaf6aeaacd74f43705a31eca.css" media="all" />
<link rel="stylesheet" href="/assets/tailwind-8c0c2aea22f6a8c030598c10314fc4180b5b41dab7784585e9c9ca70f0aa3d99.css" media="all" />


<link rel="stylesheet" href="/assets/fonts-fae5d3f79948bd85f18b6513a025f863b19636e85b09a1492907eb4b1bb0557b.css" media="all" />
<link rel="stylesheet" href="/assets/highlight/themes/white-e08c45a78f4446ec6c4226adb581d4482911bd7c85b47b7e7c003112b0c26274.css" media="all" />


<link rel="preload" href="/assets/application_utilities-4ce46b0d1744a75b5e0b7104e935413dc41b09b34002dc2832a687dd8e7f0569.css" as="style" type="text/css">
<link rel="preload" href="/assets/application-539db0d62ee9e10949bac79127c082aaa0e8d001ddda9467cd8a1d05928a9b8b.css" as="style" type="text/css">
<link rel="preload" href="/assets/highlight/themes/white-e08c45a78f4446ec6c4226adb581d4482911bd7c85b47b7e7c003112b0c26274.css" as="style" type="text/css">

<script src="/assets/locale/fr/app-df9cb3541ad7aafec85967cca7b713644af58dbf448db9fca5841f5915505391.js" defer="defer"></script>



<script src="/assets/webpack/runtime.beff6481.bundle.js" defer="defer"></script>
<script src="/assets/webpack/main.4e9cbf4e.chunk.js" defer="defer"></script>
<script src="/assets/webpack/graphql.e1f11a07.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.groups.new-pages.import.gitlab_projects.new-pages.import.manifest.new-pages.projects.n-44c6c18e.5760769e.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.search.show-super_sidebar.dff8699c.chunk.js" defer="defer"></script>
<script src="/assets/webpack/super_sidebar.802161b8.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.admin.runners.show-pages.clusters.agents.dashboard-pages.explore.catalog-pages.groups.-1d158ded.aaf2306e.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.branches.new-pages.projects.commits.show-pages.proje-81161c0b.f4a7a399.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.show-pages.projects.snippets.edit-pages.projects.sni-42df7d4c.56c2e52b.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.show-pages.projects.snippets.show-pages.projects.tre-c684fcf6.6c07ab3e.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blame.show-pages.projects.blame.streaming-pages.projects.blob.show-pages.proj-9f3d272f.0a7b0eab.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.forks.new-pages.projects.show-pages.projects.tree.show.05f0ce32.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.show-pages.projects.tree.show.49dc14a0.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.tree.show-treeList.f516e32a.chunk.js" defer="defer"></script>
<script src="/assets/webpack/commons-pages.projects.blob.show-pages.projects.commits.show-pages.projects.compare.show.b2be64a1.chunk.js" defer="defer"></script>
<script src="/assets/webpack/pages.projects.blob.show.465b251c.chunk.js" defer="defer"></script>
<meta content="object" property="og:type">
<meta content="GitLab" property="og:site_name">
<meta content="tp/utils.jl · master · toc / Etudiants N7 / Contrôle optimal · GitLab" property="og:title">
<meta content="Bienvenue sur le GITLAB de l&#39;IRIT" property="og:description">
<meta content="https://gitlab.irit.fr/uploads/-/system/project/avatar/721/logo-controle-optimal.png" property="og:image">
<meta content="64" property="og:image:width">
<meta content="64" property="og:image:height">
<meta content="https://gitlab.irit.fr/toc/etu-n7/controle-optimal/-/blob/master/tp/utils.jl?ref_type=heads" property="og:url">
<meta content="summary" property="twitter:card">
<meta content="tp/utils.jl · master · toc / Etudiants N7 / Contrôle optimal · GitLab" property="twitter:title">
<meta content="Bienvenue sur le GITLAB de l&#39;IRIT" property="twitter:description">
<meta content="https://gitlab.irit.fr/uploads/-/system/project/avatar/721/logo-controle-optimal.png" property="twitter:image">

<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="8yxvBlQ-kBbf2xEN_A0TdiHP7EzG8-QbwERcYKp2uMWqg59QEEbIifosnjnmIrz3m3002V5Wib0jlJO-RNA9rg" />
<meta name="csp-nonce" />
<meta name="action-cable-url" content="/-/cable" />
<link href="/-/manifest.json" rel="manifest">
<link rel="icon" type="image/png" href="/assets/favicon-72a2cad5025aa931d6ea56c3201d1f18e68a8cd39788c7c80d5b2b82aa5143ef.png" id="favicon" data-original-href="/assets/favicon-72a2cad5025aa931d6ea56c3201d1f18e68a8cd39788c7c80d5b2b82aa5143ef.png" />
<link rel="apple-touch-icon" type="image/x-icon" href="/assets/apple-touch-icon-b049d4bc0dd9626f31db825d61880737befc7835982586d015bded10b4435460.png" />
<link href="/search/opensearch.xml" rel="search" title="Search GitLab" type="application/opensearchdescription+xml">




<meta content="Bienvenue sur le GITLAB de l&#39;IRIT" name="description">
<meta content="#ececef" name="theme-color">
</head>

<body class="tab-width-8 gl-browser-safari gl-platform-mac  " data-find-file="/toc/etu-n7/controle-optimal/-/find_file/master?ref_type=heads" data-group="etu-n7" data-group-full-path="toc/etu-n7" data-namespace-id="1381" data-page="projects:blob:show" data-page-type-id="master/tp/utils.jl" data-project="controle-optimal" data-project-full-path="toc/etu-n7/controle-optimal" data-project-id="721">

<script>
//<![CDATA[
gl = window.gl || {};
gl.client = {"isSafari":true,"isMac":true};


//]]>
</script>



<header class="header-logged-out" data-testid="navbar">
<a class="gl-sr-only gl-accessibility" href="#content-body">Skip to content</a>
<div class="container-fluid">
<nav aria-label="Explorer GitLab" class="header-logged-out-nav gl-display-flex gl-gap-3 gl-justify-content-space-between">
<div class="gl-display-flex gl-align-items-center gl-gap-1">
<span class="gl-sr-only">GitLab</span>
<a title="Page d&#39;accueil" id="logo" class="header-logged-out-logo has-tooltip" aria-label="Page d&#39;accueil" href="/"><svg aria-hidden="true" role="img" class="tanuki-logo" width="25" height="24" viewBox="0 0 25 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path class="tanuki-shape tanuki" d="m24.507 9.5-.034-.09L21.082.562a.896.896 0 0 0-1.694.091l-2.29 7.01H7.825L5.535.653a.898.898 0 0 0-1.694-.09L.451 9.411.416 9.5a6.297 6.297 0 0 0 2.09 7.278l.012.01.03.022 5.16 3.867 2.56 1.935 1.554 1.176a1.051 1.051 0 0 0 1.268 0l1.555-1.176 2.56-1.935 5.197-3.89.014-.01A6.297 6.297 0 0 0 24.507 9.5Z"
        fill="#E24329"/>
  <path class="tanuki-shape right-cheek" d="m24.507 9.5-.034-.09a11.44 11.44 0 0 0-4.56 2.051l-7.447 5.632 4.742 3.584 5.197-3.89.014-.01A6.297 6.297 0 0 0 24.507 9.5Z"
        fill="#FC6D26"/>
  <path class="tanuki-shape chin" d="m7.707 20.677 2.56 1.935 1.555 1.176a1.051 1.051 0 0 0 1.268 0l1.555-1.176 2.56-1.935-4.743-3.584-4.755 3.584Z"
        fill="#FCA326"/>
  <path class="tanuki-shape left-cheek" d="M5.01 11.461a11.43 11.43 0 0 0-4.56-2.05L.416 9.5a6.297 6.297 0 0 0 2.09 7.278l.012.01.03.022 5.16 3.867 4.745-3.584-7.444-5.632Z"
        fill="#FC6D26"/>
</svg>

</a></div>
<ul class="gl-list-style-none gl-p-0 gl-m-0 gl-display-flex gl-gap-3 gl-align-items-center gl-flex-grow-1">
<li class="header-logged-out-nav-item">
<a class="" href="/explore">Explorer</a>
</li>
</ul>
<ul class="gl-list-style-none gl-p-0 gl-m-0 gl-display-flex gl-gap-3 gl-align-items-center gl-justify-content-end">
<li class="header-logged-out-nav-item">
<a href="/users/sign_in?redirect_to_referer=yes">Connexion</a>
</li>
</ul>
</nav>
</div>
</header>

<div class="layout-page page-with-super-sidebar">
<aside class="js-super-sidebar super-sidebar super-sidebar-loading" data-command-palette="{&quot;project_files_url&quot;:&quot;/toc/etu-n7/controle-optimal/-/files/master?format=json&quot;,&quot;project_blob_url&quot;:&quot;/toc/etu-n7/controle-optimal/-/blob/master&quot;}" data-force-desktop-expanded-sidebar="" data-root-path="/" data-sidebar="{&quot;is_logged_in&quot;:false,&quot;context_switcher_links&quot;:[{&quot;title&quot;:&quot;Explorer&quot;,&quot;link&quot;:&quot;/explore&quot;,&quot;icon&quot;:&quot;compass&quot;}],&quot;current_menu_items&quot;:[{&quot;id&quot;:&quot;project_overview&quot;,&quot;title&quot;:&quot;Contrôle optimal&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:&quot;/uploads/-/system/project/avatar/721/logo-controle-optimal.png&quot;,&quot;entity_id&quot;:721,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:&quot;shortcuts-project&quot;,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;manage_menu&quot;,&quot;title&quot;:&quot;Gestion&quot;,&quot;icon&quot;:&quot;users&quot;,&quot;avatar&quot;:null,&quot;avatar_shape&quot;:&quot;rect&quot;,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/activity&quot;,&quot;is_active&quot;:false,&quot;pill_count&quot;:null,&quot;items&quot;:[{&quot;id&quot;:&quot;activity&quot;,&quot;title&quot;:&quot;Activité&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/activity&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:&quot;shortcuts-project-activity&quot;,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;members&quot;,&quot;title&quot;:&quot;Membres&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/project_members&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;labels&quot;,&quot;title&quot;:&quot;Labels&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/labels&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false}],&quot;separated&quot;:false},{&quot;id&quot;:&quot;plan_menu&quot;,&quot;title&quot;:&quot;Programmation&quot;,&quot;icon&quot;:&quot;planning&quot;,&quot;avatar&quot;:null,&quot;avatar_shape&quot;:&quot;rect&quot;,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/issues&quot;,&quot;is_active&quot;:false,&quot;pill_count&quot;:null,&quot;items&quot;:[{&quot;id&quot;:&quot;project_issue_list&quot;,&quot;title&quot;:&quot;Tickets&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/issues&quot;,&quot;pill_count&quot;:&quot;0&quot;,&quot;link_classes&quot;:&quot;shortcuts-issues has-sub-items&quot;,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;boards&quot;,&quot;title&quot;:&quot;Tableaux des tickets&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/boards&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:&quot;shortcuts-issue-boards&quot;,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;milestones&quot;,&quot;title&quot;:&quot;Jalons&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/milestones&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false}],&quot;separated&quot;:false},{&quot;id&quot;:&quot;code_menu&quot;,&quot;title&quot;:&quot;Code&quot;,&quot;icon&quot;:&quot;code&quot;,&quot;avatar&quot;:null,&quot;avatar_shape&quot;:&quot;rect&quot;,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/tree/master&quot;,&quot;is_active&quot;:true,&quot;pill_count&quot;:null,&quot;items&quot;:[{&quot;id&quot;:&quot;files&quot;,&quot;title&quot;:&quot;Dépôt&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/tree/master&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:&quot;shortcuts-tree&quot;,&quot;is_active&quot;:true},{&quot;id&quot;:&quot;branches&quot;,&quot;title&quot;:&quot;Branches&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/branches&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;commits&quot;,&quot;title&quot;:&quot;Validations&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/commits/master?ref_type=heads&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:&quot;shortcuts-commits&quot;,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;tags&quot;,&quot;title&quot;:&quot;Étiquettes&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/tags&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;graphs&quot;,&quot;title&quot;:&quot;Graphe du dépôt&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/network/master?ref_type=heads&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:&quot;shortcuts-network&quot;,&quot;is_active&quot;:false},{&quot;id&quot;:&quot;compare&quot;,&quot;title&quot;:&quot;Comparer les révisions&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/compare?from=master\u0026to=master&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false}],&quot;separated&quot;:false},{&quot;id&quot;:&quot;monitor_menu&quot;,&quot;title&quot;:&quot;Surveillance&quot;,&quot;icon&quot;:&quot;monitor&quot;,&quot;avatar&quot;:null,&quot;avatar_shape&quot;:&quot;rect&quot;,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/issues/service_desk&quot;,&quot;is_active&quot;:false,&quot;pill_count&quot;:null,&quot;items&quot;:[{&quot;id&quot;:&quot;service_desk&quot;,&quot;title&quot;:&quot;Service d&#39;assistance&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/issues/service_desk&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false}],&quot;separated&quot;:false},{&quot;id&quot;:&quot;analyze_menu&quot;,&quot;title&quot;:&quot;Analyse&quot;,&quot;icon&quot;:&quot;chart&quot;,&quot;avatar&quot;:null,&quot;avatar_shape&quot;:&quot;rect&quot;,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/ml/experiments&quot;,&quot;is_active&quot;:false,&quot;pill_count&quot;:null,&quot;items&quot;:[{&quot;id&quot;:&quot;model_experiments&quot;,&quot;title&quot;:&quot;Expériences du modèle&quot;,&quot;icon&quot;:null,&quot;avatar&quot;:null,&quot;entity_id&quot;:null,&quot;link&quot;:&quot;/toc/etu-n7/controle-optimal/-/ml/experiments&quot;,&quot;pill_count&quot;:null,&quot;link_classes&quot;:null,&quot;is_active&quot;:false}],&quot;separated&quot;:false}],&quot;current_context_header&quot;:&quot;Projet&quot;,&quot;support_path&quot;:&quot;https://about.gitlab.com/get-help/&quot;,&quot;display_whats_new&quot;:false,&quot;whats_new_most_recent_release_items_count&quot;:4,&quot;whats_new_version_digest&quot;:&quot;981955e703369178cb87cbb7a2075060174b67907a3a4967a5a07e9d9281739e&quot;,&quot;show_version_check&quot;:null,&quot;gitlab_version&quot;:{&quot;major&quot;:16,&quot;minor&quot;:11,&quot;patch&quot;:3,&quot;suffix_s&quot;:&quot;&quot;},&quot;gitlab_version_check&quot;:null,&quot;search&quot;:{&quot;search_path&quot;:&quot;/search&quot;,&quot;issues_path&quot;:&quot;/dashboard/issues&quot;,&quot;mr_path&quot;:&quot;/dashboard/merge_requests&quot;,&quot;autocomplete_path&quot;:&quot;/search/autocomplete&quot;,&quot;search_context&quot;:{&quot;group&quot;:{&quot;id&quot;:1381,&quot;name&quot;:&quot;Etudiants N7&quot;,&quot;full_name&quot;:&quot;toc / Etudiants N7&quot;},&quot;group_metadata&quot;:{&quot;issues_path&quot;:&quot;/groups/toc/etu-n7/-/issues&quot;,&quot;mr_path&quot;:&quot;/groups/toc/etu-n7/-/merge_requests&quot;},&quot;project&quot;:{&quot;id&quot;:721,&quot;name&quot;:&quot;Contrôle optimal&quot;},&quot;project_metadata&quot;:{&quot;mr_path&quot;:&quot;/toc/etu-n7/controle-optimal/-/merge_requests&quot;,&quot;issues_path&quot;:&quot;/toc/etu-n7/controle-optimal/-/issues&quot;},&quot;code_search&quot;:true,&quot;ref&quot;:&quot;master&quot;,&quot;scope&quot;:null,&quot;for_snippets&quot;:null}},&quot;panel_type&quot;:&quot;project&quot;,&quot;shortcut_links&quot;:[{&quot;title&quot;:&quot;Extraits de code&quot;,&quot;href&quot;:&quot;/explore/snippets&quot;,&quot;css_class&quot;:&quot;dashboard-shortcuts-snippets&quot;},{&quot;title&quot;:&quot;Groupes&quot;,&quot;href&quot;:&quot;/explore/groups&quot;,&quot;css_class&quot;:&quot;dashboard-shortcuts-groups&quot;},{&quot;title&quot;:&quot;Projets&quot;,&quot;href&quot;:&quot;/explore/projects&quot;,&quot;css_class&quot;:&quot;dashboard-shortcuts-projects&quot;}]}"></aside>

<div class="content-wrapper">
<div class="mobile-overlay"></div>

<div class="alert-wrapper gl-force-block-formatting-context">

























<div class="top-bar-fixed container-fluid" data-testid="top-bar">
<div class="top-bar-container gl-display-flex gl-align-items-center gl-gap-2">
<button class="gl-button btn btn-icon btn-md btn-default btn-default-tertiary js-super-sidebar-toggle-expand super-sidebar-toggle gl-ml-n3" aria-controls="super-sidebar" aria-expanded="false" aria-label="Barre latérale de navigation principale" type="button"><svg class="s16 gl-icon gl-button-icon " data-testid="sidebar-icon"><use href="/assets/icons-0b41337f52be73f7bbf9d59b841eb98a6e790dfa1a844644f120a80ce3cc18ba.svg#sidebar"></use></svg>

</button>
<nav aria-label="Fil d&#39;Ariane" class="breadcrumbs gl-breadcrumbs tmp-breadcrumbs-fix" data-testid="breadcrumb-links">
<ul class="breadcrumb gl-breadcrumb-list js-breadcrumbs-list gl-flex-grow-1">
<li class="gl-breadcrumb-item gl-display-inline-flex"><a class="group-path js-breadcrumb-item-text " href="/toc">toc</a></li><li class="gl-breadcrumb-item gl-display-inline-flex"><a class="group-path js-breadcrumb-item-text " href="/toc/etu-n7"><img srcset="/uploads/-/system/group/avatar/1381/logo-etu-n7.png?width=16 1x, /uploads/-/system/group/avatar/1381/logo-etu-n7.png?width=32 2x" alt="Etudiants N7" class="gl-avatar gl-avatar-s16 avatar-tile gl-rounded-base!" height="16" width="16" loading="lazy" src="/uploads/-/system/group/avatar/1381/logo-etu-n7.png?width=16" />
Etudiants N7</a></li> <li class="gl-breadcrumb-item gl-display-inline-flex"><a class="gl-display-inline-flex!" href="/toc/etu-n7/controle-optimal"><img srcset="/uploads/-/system/project/avatar/721/logo-controle-optimal.png?width=16 1x, /uploads/-/system/project/avatar/721/logo-controle-optimal.png?width=32 2x" alt="Contrôle optimal" class="gl-avatar gl-avatar-s16 avatar-tile gl-rounded-base!" height="16" width="16" loading="lazy" src="/uploads/-/system/project/avatar/721/logo-controle-optimal.png?width=16" />
<span class="js-breadcrumb-item-text">Contrôle optimal</span></a></li>

<li class="gl-breadcrumb-item" data-testid="breadcrumb-current-link">
<a href="/toc/etu-n7/controle-optimal/-/blob/master/tp/utils.jl?ref_type=heads">Dépôt</a>
</li>
</ul>
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"toc","item":"https://gitlab.irit.fr/toc"},{"@type":"ListItem","position":2,"name":"Etudiants N7","item":"https://gitlab.irit.fr/toc/etu-n7"},{"@type":"ListItem","position":3,"name":"Contrôle optimal","item":"https://gitlab.irit.fr/toc/etu-n7/controle-optimal"},{"@type":"ListItem","position":4,"name":"Dépôt","item":"https://gitlab.irit.fr/toc/etu-n7/controle-optimal/-/blob/master/tp/utils.jl?ref_type=heads"}]}

</script>
</nav>



</div>
</div>

</div>
<div class="container-fluid container-limited project-highlight-puc">
<main class="content" id="content-body" itemscope itemtype="http://schema.org/SoftwareSourceCode">
<div class="flash-container flash-container-page sticky" data-testid="flash-container">
<div id="js-global-alerts"></div>
</div>





<div class="js-signature-container" data-signatures-path="/toc/etu-n7/controle-optimal/-/commits/6ed846e82df0482eaf41b1a7cccbe3518bb2e9a1/signatures?limit=1"></div>

<div class="tree-holder gl-pt-4" id="tree-holder">
<div class="nav-block">
<div class="tree-ref-container">
<div class="tree-ref-holder gl-max-w-26">
<div data-project-id="721" data-project-root-path="/toc/etu-n7/controle-optimal" data-ref="master" data-ref-type="heads" id="js-tree-ref-switcher"></div>
</div>
<ul class="breadcrumb repo-breadcrumb">
<li class="breadcrumb-item">
<a href="/toc/etu-n7/controle-optimal/-/tree/master?ref_type=heads">controle-optimal
</a></li>
<li class="breadcrumb-item">
<a href="/toc/etu-n7/controle-optimal/-/tree/master/tp?ref_type=heads">tp</a>
</li>
<li class="breadcrumb-item">
<a href="/toc/etu-n7/controle-optimal/-/blob/master/tp/utils.jl?ref_type=heads"><strong>utils.jl</strong>
</a></li>
</ul>
</div>
<div class="tree-controls gl-display-flex gl-flex-wrap gl-sm-flex-nowrap gl-align-items-baseline gl-gap-3">
<button class="gl-button btn btn-md btn-default has-tooltip shortcuts-find-file" title="Go to file, press &lt;kbd class=&#39;flat ml-1&#39; aria-hidden=true&gt;/~&lt;/kbd&gt; or &lt;kbd class=&#39;flat ml-1&#39; aria-hidden=true&gt;t&lt;/kbd&gt;" aria-keyshortcuts="/+~ t" data-html="true" type="button"><span class="gl-button-text">
Rechercher un fichier

</span>

</button>
<a data-event-tracking="click_blame_control_on_blob_page" class="gl-button btn btn-md btn-default js-blob-blame-link" href="/toc/etu-n7/controle-optimal/-/blame/master/tp/utils.jl?ref_type=heads"><span class="gl-button-text">
Blame
</span>

</a>
<a data-event-tracking="click_history_control_on_blob_page" class="gl-button btn btn-md btn-default " href="/toc/etu-n7/controle-optimal/-/commits/master/tp/utils.jl?ref_type=heads"><span class="gl-button-text">
Historique
</span>

</a>
<a aria-keyshortcuts="y" class="gl-button btn btn-md btn-default has-tooltip js-data-file-blob-permalink-url" data-html="true" title="Accéder au permalien &lt;kbd class=&#39;flat ml-1&#39; aria-hidden=true&gt;y&lt;/kbd&gt;" href="/toc/etu-n7/controle-optimal/-/blob/fb80aa24788c1d827be4e51bbdbc4ac3a5c9eddc/tp/utils.jl"><span class="gl-button-text">
Lien permanent
</span>

</a>
</div>
</div>

<div class="info-well d-none d-sm-block">
<div class="well-segment">
<ul class="blob-commit-info">
<li class="commit flex-row js-toggle-container" id="commit-6ed846e8">
<div class="avatar-cell d-none d-sm-block">
<a href="/ocots"><img alt="Olivier Cots&#39;s avatar" src="https://secure.gravatar.com/avatar/64005f646fcc6afa0d78d609adfbd2a18eb9e0b89cdd5eaf7b805faa37c0385b?s=160&amp;d=identicon" class="avatar s40 gl-display-none gl-sm-display-inline-block" title="Olivier Cots"></a>
</div>
<div class="commit-detail flex-list gl-display-flex gl-justify-content-space-between gl-align-items-center gl-flex-grow-1 gl-min-w-0">
<div class="commit-content" data-testid="commit-content">
<a class="commit-row-message item-title js-onboarding-commit-item " href="/toc/etu-n7/controle-optimal/-/commit/6ed846e82df0482eaf41b1a7cccbe3518bb2e9a1">foo</a>
<span class="commit-row-message d-inline d-sm-none">
&middot;
6ed846e8
</span>
<div class="committer">
<a class="commit-author-link js-user-link" data-user-id="61" href="/ocots">Olivier Cots</a> a rédigé <time class="js-timeago" title="avr. 24, 2024 10:29am" datetime="2024-04-24T10:29:22Z" data-toggle="tooltip" data-placement="bottom" data-container="body">avr. 24, 2024</time>
</div>

</div>
<div class="commit-actions flex-row">

<div class="js-commit-pipeline-status" data-endpoint="/toc/etu-n7/controle-optimal/-/commit/6ed846e82df0482eaf41b1a7cccbe3518bb2e9a1/pipelines?ref=master"></div>
<div class="commit-sha-group btn-group d-none d-sm-flex">
<div class="label label-monospace monospace">
6ed846e8
</div>
<button class="gl-button btn btn-icon btn-md btn-default " title="Copier le SHA de la validation" aria-label="Copier le SHA de la validation" aria-live="polite" data-toggle="tooltip" data-placement="bottom" data-container="body" data-html="true" data-category="primary" data-size="medium" data-clipboard-text="6ed846e82df0482eaf41b1a7cccbe3518bb2e9a1" type="button"><svg class="s16 gl-icon gl-button-icon " data-testid="copy-to-clipboard-icon"><use href="/assets/icons-0b41337f52be73f7bbf9d59b841eb98a6e790dfa1a844644f120a80ce3cc18ba.svg#copy-to-clipboard"></use></svg>

</button>

</div>
</div>
</div>
</li>

</ul>
</div>

</div>
<div class="blob-content-holder js-per-page" data-blame-per-page="1000" id="blob-content-holder">
<div data-blob-path="tp/utils.jl" data-original-branch="master" data-project-path="toc/etu-n7/controle-optimal" data-ref-type="heads" data-resource-id="gid://gitlab/Project/721" data-target-branch="master" data-user-id="" id="js-view-blob-app">
<div class="gl-spinner-container" role="status"><span aria-label="Chargement en cours" class="gl-spinner gl-spinner-md gl-spinner-dark gl-vertical-align-text-bottom!"></span></div>
</div>
</div>

</div>
<script>
//<![CDATA[
  window.gl = window.gl || {};
  window.gl.webIDEPath = '/-/ide/project/toc/etu-n7/controle-optimal/edit/master/-/tp/utils.jl'


//]]>
</script>
<div data-ambiguous="false" data-ref="master" id="js-ambiguous-ref-modal"></div>

</main>
</div>


</div>
</div>


<script>
//<![CDATA[
if ('loading' in HTMLImageElement.prototype) {
  document.querySelectorAll('img.lazy').forEach(img => {
    img.loading = 'lazy';
    let imgUrl = img.dataset.src;
    // Only adding width + height for avatars for now
    if (imgUrl.indexOf('/avatar/') > -1 && imgUrl.indexOf('?') === -1) {
      const targetWidth = img.getAttribute('width') || img.width;
      imgUrl += `?width=${targetWidth}`;
    }
    img.src = imgUrl;
    img.removeAttribute('data-src');
    img.classList.remove('lazy');
    img.classList.add('js-lazy-loaded');
    img.dataset.testid = 'js-lazy-loaded-content';
  });
}

//]]>
</script>
<script>
//<![CDATA[
gl = window.gl || {};
gl.experiments = {};


//]]>
</script>

</body>
</html>

