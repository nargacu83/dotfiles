/***********************************************************
*
* name: user.js
* date: 2021-09-30
* version: 0.1
* maintainer: Brainf+ck
*
* For more information how to use this file see:
* https://github.com/arkenfox/user.js/wiki/1.1-Overview
*
***********************************************************/


/* For detailed information about these entries see:
 * http://kb.mozillazine.org/Firefox_%3A_FAQs_%3A_About%3Aconfig_Entries
 */

/* FORMAT:
 * user_pref("<entry>", <boolean> || "<string/number>" );
 */


/** Basic Preferences **/

user_pref("font.name.serif.x-western", "Cantarell");
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.toolbars.bookmarks.visibility", "never");
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[\"ublock0_raymondhill_net-browser-action\",\"_b7f9d2cd-d772-4302-8c3f-eb941af36f76_-browser-action\",\"_contain-facebook-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"addon_darkreader_org-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"addon_darkreader_org-browser-action\",\"_contain-facebook-browser-action\",\"_b7f9d2cd-d772-4302-8c3f-eb941af36f76_-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"widget-overflow-fixed-list\"],\"currentVersion\":17,\"newElementCount\":3}");

user_pref("browser.newtabpage.pinned", "[]");
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false);

// Search Engine
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
user_pref("browser.search.hiddenOneOffs", "Google,Bing,eBay,Qwant,Wikipédia (fr)");
user_pref("extensions.reset_default_search.runonce.3", true);

/** HTTPS Only **/
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

/** about:config **/

// disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

/** StartUp Settings **/

// disable activity and telemetry on new tab pages
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");

/** Geolocation **/

// use Mozilla geolocation service instead of Google if permission is granted
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");

// disable using the OS’s geolocation service
//user_pref("geo.provider.ms-windows-location", false); //Windows
//user_pref("geo.provider.use_corelocation", false); //macOS
user_pref("geo.provider.use_gpsd", false); //Linux

// disable region updates
user_pref("browser.region.network.url", "");
user_pref("browser.region.update.enabled", false);

/** Language / Locale **/

// set language for displaying web pages:
user_pref("intl.accept_languages", "en-US, en");
user_pref("javascript.use_us_english_locale", true); //Hidden Pref

/** Auto-updates and Recommendations **/

// disable auto-installing Firefox updates
//user_pref("app.update.background.scheduling.enabled", false); //Windows
user_pref("app.update.auto", false); //Non-Windows

// disable addons recommendations (use Google Analytics)
user_pref("extensions.getAddons.showPane", false); //Hidden Pref
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

/** Telemetry **/

// disable telemetry
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.enabled", false); //as default
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true); //Hidden Pref
user_pref("toolkit.coverage.opt-out", true); //Hidden Pref
user_pref("toolkit.coverage.endpoint.base.", "");
user_pref("browser.ping-centre.telemetry", false);

/** Studies **/

// disable studies
user_pref("datareporting.policy.dataSubmissionEnable", false);

// disable normandy/shield
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/** Captive Portal Detection / Network Checks **/

// disable captive portal detection
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);

/** Safe Browsing **/

// disable safe browsing service
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");

/** Prefetching **/

// disable link prefetching
user_pref("network.prefetch-next", false);

// disable DNS prefetching
user_pref("network.dns.disablePrefetch", true);

// disable predictor
user_pref("network.predictor.enabled", false);

/** Network **/

// disable IPv6
user_pref("network.dns.disableIPv6", true);

/** Search Bar / Autofill **/

// display all parts of the url in the bar
user_pref("browser.urlbar.trimURLs", false);

// disable form autofill
user_pref("browser.formfill.enable", false);
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.available", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);
user_pref("signon.autofillForms", false);

/** Cache / Memory **/

// disable disk cache
user_pref("browser.cache.disk.enable", false);

// disable storing extra session data
user_pref("browser.sessionstore.privacy_level", 2);

// set the minimum interval between session save operations
user_pref("browser.sessionstore.interval", 30000);

/** Headers / Referers **/

/* control when to send a referer:
 *    0=always (default)
 *    1=only if base domains match
 *    2=only if hosts match
 */
user_pref("network.http.referer.XOriginPolicy", 2);

// do not track header
user_pref("privacy.donottrackheader.enabled", true);

/** WebRTC **/

// disable WebRTC
user_pref("media.peerconnection.enabled", false);

// limit WebRTC IP leaks if using it
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);

/** Cookies **/

// disable 3rd-party cookies and site-data
user_pref("network.cookie.cookieBehavior", 1);
user_pref("browser.contentblocking.category", "custom");

/** Shutdown **/

// clear history when Firefox closes
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", true);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.sessions", true);
user_pref("privacy.clearOnShutdown.sitesettings", true);

/** WebGL (Web Graphics Library) **/

// disable WebGL
user_pref("webgl.disabled", true);