GLOBAL guitextgreen IS RGB(20/255,255/255,21/255).
global trajbgblack IS RGB(5/255,8/255,8/255).

GLOBAL main_gui_width IS 550.
GLOBAL main_gui_height IS 510.


FUNCTION make_main_GUI {
	

	//create the GUI.
	GLOBAL main_gui is gui(main_gui_width,main_gui_height).
	SET main_gui:X TO 200.
	SET main_gui:Y TO 670.
	SET main_gui:STYLe:WIDTH TO main_gui_width.
	SET main_gui:STYLe:HEIGHT TO main_gui_height.
	SET main_gui:STYLE:ALIGN TO "center".
	SET main_gui:STYLE:HSTRETCH  TO TRUE.

	set main_gui:skin:LABEL:TEXTCOLOR to guitextgreen.


	// Add widgets to the GUI
	GLOBAL title_box is main_gui:addhbox().
	set title_box:style:height to 35. 
	set title_box:style:margin:top to 0.


	GLOBAL text0 IS title_box:ADDLABEL("<b><size=20>SPACE SHUTTLE OPS1 ASCENT GUIDANCE</size></b>").
	SET text0:STYLE:ALIGN TO "center".

	GLOBAL minb IS  title_box:ADDBUTTON("-").
	set minb:style:margin:h to 7.
	set minb:style:margin:v to 7.
	set minb:style:width to 20.
	set minb:style:height to 20.
	set minb:TOGGLE to TRUE.
	function minimizecheck {
		PARAMETER pressed.
		
		IF pressed {
			main_gui:SHOWONLY(title_box).
			SET main_gui:STYLe:HEIGHT TO 50.
		} ELSE {
			SET main_gui:STYLe:HEIGHT TO main_gui_height.
			for w in main_gui:WIDGETS {
				w:SHOW().
			}
		}
		
	}
	SET minb:ONTOGGLE TO minimizecheck@.

	GLOBAL quitb IS  title_box:ADDBUTTON("X").
	set quitb:style:margin:h to 7.
	set quitb:style:margin:v to 7.
	set quitb:style:width to 20.
	set quitb:style:height to 20.
	function quitcheck {
	  SET quit_program TO TRUE.
	}
	SET quitb:ONCLICK TO quitcheck@.

	
	main_gui:addspacing(7).
	
	
	GLOBAL toggles_box IS main_gui:ADDHLAYOUT().
	SET toggles_box:STYLE:WIDTH TO 300.
	toggles_box:addspacing(55).	
	SET toggles_box:STYLE:ALIGN TO "center".
	
	main_gui:SHOW().
	
}

FUNCTION close_global_GUI {
	main_gui:HIDE().
	IF (DEFINED(hud_gui)) {
		hud_gui:HIDE.
		hud_gui:DISPOSE.
		
	}
}

FUNCTION close_all_GUIs{
	CLEARGUIS().
}
