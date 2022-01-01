package require http

# Change package name for you extension / plugin
set plugin_name "reservoir"

namespace eval ::plugins::${plugin_name} {
        
    # These are shown in the plugin selection page
    variable author "Matthew Nitschke"
    variable contact "email@coffee-mail.de"
    variable version 1.0
    variable description "Minimal plugin to showcase the interface of the plugin / extensions system."
    variable name "Reservoir"

    # Always on entry point
    proc preload {} {
        return [build_ui]
    }

    proc build_ui {}  {
        variable settings

        # Unique name per page
        set page_name "reservior_settings_page"

        # Background image and "Done" button
        add_de1_page "$page_name" "settings_message.png" "default"
        add_de1_text $page_name 1280 1310 -text [translate "Done"] -font Helv_10_bold -fill "#fAfBff" -anchor "center"
        add_de1_button $page_name {say [translate {Done}] $::settings(sound_button_in); page_to_show_when_off extensions}  980 1210 1580 1410 ""

        # Headline
        add_de1_text $page_name 1280 300 -text [translate "Reservoir Plugin"] -font Helv_20_bold -width 1200 -fill "#444444" -anchor "center" -justify "center"


        # add_de1_text $page_name 280 480 -text [translate "Username"] -font Helv_8 -width 300 -fill "#444444" -anchor "nw" -justify "center"
        # add_de1_widget "$page_name" entry 280 540  {
        #     bind $widget <Return> { say [translate {save}] $::settings(sound_button_in); borg toast [translate "Saved"]; save_plugin_settings reservoir; hide_android_keyboard}
        #     bind $widget <Leave> hide_android_keyboard
        # } -width [expr {int(38 * $::globals(entry_length_multiplier))}] -font Helv_8  -borderwidth 1 -bg #fbfaff  -foreground #4e85f4 -textvariable ::plugins::reservior::settings(visualizer_username) -relief flat  -highlightthickness 1 -highlightcolor #000000

        return $page_name
    }

    proc check_reservoir_status {event_dict} {
        set url "http://192.168.1.66:8080"

        set token [http::geturl $url -method GET -timeout 30000]

        set code [http::ncode $token]

        if {$code == 400} {
            msg "Warning: Reservoir Full"
            borg toast [translate "Warning: Reservoir Full"]
        }
    }

    proc main {} {
        ::de1::event::listener::on_major_state_change_add ::plugins::reservoir::check_reservoir_status
    }
}