user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.startup.homepage", "about:home");
user_pref("browser.newtabpage.enabled", true);
/* override recipe: enable session restore ***/
user_pref("browser.startup.page", 1); // 0102
  // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
  // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
user_pref("privacy.clearOnShutdown.history", false); // 2811 FF127 or lower
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // 2811 FF128+

