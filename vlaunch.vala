using Gtk;

void doit (string query, bool privatep) {
    Regex url = /^(https?|ftp):\/\/[a-z0-9.]*\.[a-z]{2,5}/;
    //stderr.printf ("%s\n", query);
    //stderr.printf ("Switch is: %s\n", privatep ? "on" : "off");
    if (url.match(query)) {
        //stderr.printf ("This is a URL.\n");
        Posix.execvp("firefox", {privatep ? "--private-window" : "--new-tab", "--new-tab", query});
    } else {
        Posix.execvp("firefox", {privatep ? "--private-window" : "--new-tab", "--new-tab", @"https://duckduckgo.com/?q=$query"});
    }
}

int main (string[] args) {

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

    button.clicked.connect (() => {doit (entry.get_text(), toggle.get_state());});
    entry.activate.connect (() => {doit (entry.get_text(), toggle.get_state());});

    window.show_all ();
    Gtk.main ();

    return 0;
}
