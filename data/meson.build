# Configure and install the desktop file
desktop_file_conf = configuration_data()
desktop_file_conf.set('COMMAND', meson.project_name())
desktop_file_conf.set('ICON_NAME', app_id)

configured_desktop_file = configure_file(
            input: '@0@.desktop.in.in'.format(meson.project_name()),
           output: '@0@.desktop.in'.format(meson.project_name()),
    configuration: desktop_file_conf,
)

desktop_file = i18n.merge_file(
          input: configured_desktop_file,
         output: '@0@.desktop'.format(app_id),
         po_dir: meson.source_root() / 'po',
           type: 'desktop',
        install: true,
    install_dir: datadir / 'applications',
)

# Verify if the desktop file is valid
desktop_file_validate = find_program('desktop-file-validate', required: false)

if desktop_file_validate.found()
    test('Validate desktop file', desktop_file_validate,
        args: desktop_file
    )
endif

# Configure and install the appdata file
appdata_file_conf = configuration_data()
appdata_file_conf.set('APP_ID', app_id)
appdata_file_conf.set('GETTEXT_PACKAGE', gettext_package)

configured_appdata_file = configure_file(
            input: '@0@.metainfo.xml.in.in'.format(meson.project_name()),
           output: '@0@.metainfo.xml.in'.format(meson.project_name()),
    configuration: appdata_file_conf,
)

appdata_file = i18n.merge_file(
          input: configured_appdata_file,
         output: '@0@.metainfo.xml'.format(app_id),
         po_dir: meson.source_root() / 'po',
           type: 'xml',
        install: true,
    install_dir: datadir / 'metainfo'
)

# Verify if the appdata file is valid
appstream_util = find_program('appstream-util', required: false)

if appstream_util.found()
    test('Validate appdata file', appstream_util,
        args: ['validate', appdata_file],
    )
endif

# Configure and install the gschemas file
gschemas_file_conf = configuration_data()
gschemas_file_conf.set('APP_ID', app_id)
gschemas_file_conf.set('GETTEXT_PACKAGE', gettext_package)

configure_file(
            input: '@0@.gschema.xml.in'.format(meson.project_name()),
           output: '@0@.gschema.xml'.format(app_id),
    configuration: gschemas_file_conf,
          install: true,
      install_dir: datadir / 'glib-2.0' / 'schemas',
)

# Verify if the gschemas file is valid
glib_compile_schemas = find_program('glib-compile-schemas', required: false)

if glib_compile_schemas.found()
    test('Validate gschemas file', glib_compile_schemas,
        args: ['--strict', '--dry-run', meson.current_build_dir()]
    )
endif

subdir('icons')
