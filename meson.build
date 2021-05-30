project('com.github.nahuelwexd.GtkValaTemplate', 'vala', 'c',
            version: '0.1.0',
            license: 'MIT',
      meson_version: '>= 0.50.0',
    default_options: ['warning_level=2'],
)

# Defines the gettext package. Required to use gettext.
add_project_arguments('-DGETTEXT_PACKAGE=@0@'.format(meson.project_name()),
    language: 'c',
)

# Add additional runtime checks in Vala. Improves type safety in C.
add_project_arguments('--enable-checking',
    language: 'vala',
)

# Check the profile for this build
if get_option('profile') == 'development'
    profile = '.Devel'

    add_project_arguments('-D', 'DEVEL',
        language: 'vala'
    )
else
    profile = ''
endif

# Define global variables
gnome     = import('gnome')
i18n      = import('i18n')
prefix    = get_option('prefix')
datadir   = prefix / get_option('datadir')
localedir = prefix / get_option('localedir')

# Define the app metadata
app_id          = '@0@@1@'.format(meson.project_name(), profile)
project_website = 'https://github.com/nahuelwexd/GTK-Vala-Template'
resource_path   = '/com/github/nahuelwexd/GtkValaTemplate'
version         = '@0@-@VCS_TAG@'.format(meson.project_version())
gettext_package = meson.project_name()

# Generate a header with the metadata
config_h = configuration_data()
config_h.set_quoted('APP_ID', app_id)
config_h.set_quoted('PROJECT_WEBSITE', project_website)
config_h.set_quoted('RESOURCE_PATH', resource_path)
config_h.set_quoted('VERSION', version)
config_h.set_quoted('GETTEXT_PACKAGE', gettext_package)
config_h.set_quoted('LOCALEDIR', localedir)

config_h_in = configure_file(
           output: 'config.h.in',
    configuration: config_h,
)

vcs_tag(
     command: ['git', 'rev-parse', '--short', 'HEAD'],
    fallback: get_option('profile') != 'default' ? 'devel' : 'stable',
       input: config_h_in,
      output: 'config.h',
)

confinc = include_directories('.')

# Subdirectories
subdir('data')
subdir('src')
subdir('po')

# Post install script
meson.add_install_script('build-aux/meson/post-install.py')
