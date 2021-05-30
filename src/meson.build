sources = [
    'app.vala',
    'main-window.vala',
]

ui_resources = gnome.compile_resources('ui-resources', 'ui-resources.xml')

# Define the project dependencies
valac   = meson.get_compiler('vala')
vapidir = meson.source_root() / 'vapi'

deps = [
    dependency('gio-2.0', version: '>=2.66'),
    dependency('gtk4', version: '>=4.0'),
    valac.find_library('config', dirs: vapidir),
]

# Compile the app executable
executable(meson.project_name(), sources, ui_resources,
           dependencies: deps,
                install: true,
                gui_app: true,
    include_directories: confinc,
)
