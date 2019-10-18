using Gtk;

void doit (string query, bool privatep, Json.Object cfgObj) {
    Regex url = /^(https?|ftp):\/\/[a-z0-9.]*\.[a-z]{2,5}/;
    //stderr.printf ("%s\n", query);
    //stderr.printf ("Switch is: %s\n", privatep ? "on" : "off");
    Array<string> argumentList = new Array<string> ();
    argumentList.append_val (cfgObj.get_string_member ("new-tab-option"));
    if (privatep) {
        argumentList.append_val (cfgObj.get_string_member ("private-option"));
    }
    if (url.match (query)) {
        //stderr.printf ("This is a URL.\n");
        argumentList.append_val (query);
    } else {
        argumentList.append_val (string.join ("", cfgObj.get_string_member ("search-engine-url"), query));
    }
    Posix.execvp(cfgObj.get_string_member ("browser-exec"), argumentList.data);
}

int main (string[] args) {
    string configString;
    FileUtils.get_contents ("config.json", out configString);

    var configParser = new Json.Parser ();
    configParser.load_from_data (configString, -1);
    var configObject = configParser.get_root ().get_object ();

    Gtk.init (ref args);

    var builder = new Builder ();
    /* Getting the glade file */
    builder.add_from_file ("vlaunch.glade");
    builder.connect_signals (null);
    var window = builder.get_object ("vlaunch") as Window;
    var entry = builder.get_object ("query") as Entry;
    var button = builder.get_object ("launch") as Button;
    var toggle = builder.get_object ("private") as Switch;
    window.destroy.connect(Gtk.main_quit);

    toggle.set_state (configObject.get_boolean_member ("default-to-private"));

    button.clicked.connect (() => {
        doit (entry.get_text (), toggle.get_state (), configObject);
    });
    entry.activate.connect (() => {
        doit (entry.get_text (), toggle.get_state (), configObject);
    });

    window.show_all ();
    Gtk.main ();

    return 0;
}
