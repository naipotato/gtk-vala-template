public class GtkValaTemplate.App : Gtk.Application {
    private App () {
        Object (
#if DEVEL
            // In development builds, force the resource base path to be the
            // same as the one we use in release builds, so as not to have to
            // manually load icons, shorcuts window, and other automatic
            // resources, avoiding future headaches.
            resource_base_path: Constants.RESOURCE_PATH,
#endif
            application_id: Constants.APP_ID
        );
    }

    private static int main (string[] args) {
        // Configure project localizations
        // See https://developer.gnome.org/glib/stable/glib-I18N.html
        Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
        Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Constants.GETTEXT_PACKAGE);

        return new App ().run (args);
    }

    protected override void activate () {
        this.active_window.present ();
    }

    protected override void startup () {
        base.startup ();

        // TRANSLATORS: This is the app name
        Environment.set_application_name (_("GTK Vala Template"));

        // Load the custom stylesheet
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource (@"$(this.resource_base_path)/styles.css");

        Gdk.Display? display = Gdk.Display.get_default ();
        if (display != null)
            Gtk.StyleContext.add_provider_for_display (display, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        // Register the action to display the about dialog
        var about_action = new SimpleAction ("show-about", null);
        about_action.activate.connect (this.show_about_dialog);
        this.add_action (about_action);

        // Register the action to close the app on Ctrl + Q
        var quit_action = new SimpleAction ("quit", null);
        quit_action.activate.connect (this.quit);
        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });
        this.add_action (quit_action);

        // Initialize main window
        new MainWindow (this);
    }

    private void show_about_dialog () {
        var about_dialog = new Gtk.AboutDialog () {
            transient_for = this.active_window,
            modal = true,
            destroy_with_parent = true,
            // TRANSLATORS: This is the title of the About dialog
            title = _("About GTK Vala Template"),
            logo_icon_name = Constants.APP_ID,
            version = Constants.VERSION,
            // TRANSLATORS: This is the summary of the app
            comments = _("A GTK + Vala application template"),
            website = Constants.PROJECT_WEBSITE,
            // TRANSLATORS: This is the label of the link to the app's repository
            website_label = _("Project repository"),
            copyright = "© 2021 Nahuel Gomez Castro",
            license_type = Gtk.License.MIT_X11,
            authors = { "Nahuel Gomez Castro <nahuel.gomezcastro@outlook.com.ar>" }
        };

        about_dialog.present ();
    }
}
