[GtkTemplate (ui = "/com/github/nahuelwexd/GtkValaTemplate/main-window.ui")]
public class GtkValaTemplate.MainWindow : Gtk.ApplicationWindow {
    private uint _resize_id = 0;
    private Settings _settings = new Settings (Constants.APP_ID);

    public MainWindow (App app) {
        Object (application: app);
    }

    [GtkCallback]
    private void save_window_size () {
        if (this._resize_id != 0)
            Source.remove (this._resize_id);

        this._resize_id = Timeout.add (100, () => {
            this._resize_id = 0;

            if (maximized) {
                this._settings.set_boolean ("is-maximized", true);
            } else {
                this._settings.set_boolean ("is-maximized", false);
                this._settings.set_int ("window-height", this.default_height);
                this._settings.set_int ("window-width", this.default_width);
            }

            return Source.REMOVE;
        });
    }

    construct {
        this.default_height = this._settings.get_int ("window-height");
        this.default_width = this._settings.get_int ("window-width");

        if (this._settings.get_boolean ("is-maximized"))
            this.maximize ();

#if DEVEL
        this.add_css_class ("devel");
#endif
    }
}
