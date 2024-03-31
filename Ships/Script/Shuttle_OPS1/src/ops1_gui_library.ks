GLOBAL guitextgreen IS RGB(20/255,255/255,21/255).
global trajbgblack IS RGB(5/255,8/255,8/255).

GLOBAL guitextgreenhex IS "14ff15".
GLOBAL guitextredhex IS "ff1514".
GLOBAL guitextyellowhex IS "fff600".

GLOBAL main_ascent_gui_width IS 550.
GLOBAL main_ascent_gui_height IS 555.


FUNCTION make_main_ascent_gui {
	

	//create the GUI.
	GLOBAL main_ascent_gui is gui(main_ascent_gui_width,main_ascent_gui_height).
	SET main_ascent_gui:X TO 185.
	SET main_ascent_gui:Y TO 640.
	SET main_ascent_gui:STYLe:WIDTH TO main_ascent_gui_width.
	SET main_ascent_gui:STYLe:HEIGHT TO main_ascent_gui_height.
	SET main_ascent_gui:STYLE:ALIGN TO "center".
	SET main_ascent_gui:STYLE:HSTRETCH  TO TRUE.

	set main_ascent_gui:skin:LABEL:TEXTCOLOR to guitextgreen.


	// Add widgets to the GUI
	GLOBAL title_box is main_ascent_gui:addhbox().
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
			main_ascent_gui:SHOWONLY(title_box).
			SET main_ascent_gui:STYLe:HEIGHT TO 50.
		} ELSE {
			SET main_ascent_gui:STYLe:HEIGHT TO main_gui_height.
			for w in main_ascent_gui:WIDGETS {
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

	
	main_ascent_gui:addspacing(6).
	
	
	GLOBAL ascent_toggles_box IS main_ascent_gui:ADDHLAYOUT().
	SET ascent_toggles_box:STYLE:WIDTH TO main_ascent_gui_width - 16.
	
	GLOBAL dap_b_box IS ascent_toggles_box:ADDHLAYOUT().
	SET dap_b_box:STYLE:WIDTH TO 120.
	GLOBAL dap_b_text IS dap_b_box:ADDLABEL("DAP").
	set dap_b_text:style:margin:v to -3.
	GLOBAL dap_b IS dap_b_box:addpopupmenu().
	set dap_b:style:margin:v to -3.
	SET dap_b:STYLE:WIDTH TO 70.
	SET dap_b:STYLE:HEIGHT TO 25.
	SET dap_b:STYLE:ALIGN TO "center".
	dap_b:addoption("AUTO").
	dap_b:addoption("CSS").
	ascent_toggles_box:addspacing(15).
	
	GLOBAL abort_mode_box IS ascent_toggles_box:ADDHLAYOUT().
	SET abort_mode_box:STYLE:WIDTH TO 120.
	GLOBAL abort_mode_text IS abort_mode_box:ADDLABEL("Mode").
	set abort_mode_text:style:margin:v to -3.
	GLOBAL abort_mode_select IS abort_mode_box:addpopupmenu().
	set abort_mode_select:style:margin:v to -3.
	SET abort_mode_select:STYLE:WIDTH TO 70.
	SET abort_mode_select:STYLE:HEIGHT TO 25.
	SET abort_mode_select:STYLE:ALIGN TO "center".

	ascent_toggles_box:addspacing(15).
	
	GLOBAL abort_b is ascent_toggles_box:ADDBUTTON("ABORT").
	SET abort_b:STYLE:WIDTH TO 55.
	SET abort_b:STYLE:HEIGHT TO 25.
	set abort_b:style:margin:v to -3.
	set abort_b:STYLE:BG to "Shuttle_OPS1/src/gui_images/abort_btn.png".
	
	ascent_toggles_box:addspacing(15).
	
	GLOBAL tal_site_box IS ascent_toggles_box:ADDHLAYOUT().
	SET tal_site_box:STYLE:WIDTH TO 180.
	GLOBAL tal_site_text IS tal_site_box:ADDLABEL("TAL site").
	set tal_site_text:style:margin:v to -3.
	GLOBAL tal_site_select IS tal_site_box:addpopupmenu().
	set tal_site_select:style:margin:v to -3.
	SET tal_site_select:STYLE:WIDTH TO 110.
	SET tal_site_select:STYLE:HEIGHT TO 25.
	SET tal_site_select:STYLE:ALIGN TO "center".
	
	
	
	GLOBAL ascent_traj_disp_counter IS 1.				   			   
	
	main_ascent_gui:addspacing(6).
	GLOBAL ascent_traj_disp IS main_ascent_gui:addvlayout().
	SET ascent_traj_disp:STYLE:WIDTH TO main_ascent_gui_width - 16.
	SET ascent_traj_disp:STYLE:HEIGHT TO 380.
	SET ascent_traj_disp:STYLE:ALIGN TO "center".
	
	set ascent_traj_disp:style:BG to "Shuttle_OPS1/src/gui_images/ascent_traj_bg.png".

	GLOBAL ascent_traj_disp_titlebox IS ascent_traj_disp:ADDHLAYOUT().
	SET ascent_traj_disp_titlebox:STYLe:WIDTH TO ascent_traj_disp:STYLE:WIDTH.
	SET ascent_traj_disp_titlebox:STYLe:HEIGHT TO 1.
	GLOBAL ascent_traj_disp_title IS ascent_traj_disp_titlebox:ADDLABEL("").
	SET ascent_traj_disp_title:STYLE:ALIGN TO "center".
	
	GLOBAL ascent_traj_disp_clockbox IS ascent_traj_disp:ADDHLAYOUT().
	SET ascent_traj_disp_clockbox:STYLe:WIDTH TO ascent_traj_disp:STYLE:WIDTH.
	SET ascent_traj_disp_clockbox:STYLe:HEIGHT TO 1.
	GLOBAL ascent_traj_disp_clock IS ascent_traj_disp_clockbox:ADDLABEL("MET 00:00:00:00").
	SET ascent_traj_disp_clock:STYLE:ALIGN TO "right".
	SET ascent_traj_disp_clock:STYLE:margin:h to 20.
	
	ascent_traj_disp:addspacing(18).
	
	GLOBAL ascent_traj_disp_overlaiddata IS ascent_traj_disp:ADDVLAYOUT().
	SET ascent_traj_disp_overlaiddata:STYLE:ALIGN TO "Center".
	SET ascent_traj_disp_overlaiddata:STYLe:WIDTH TO ascent_traj_disp:STYLE:WIDTH.
	SET ascent_traj_disp_overlaiddata:STYLe:HEIGHT TO 1.
	
	GLOBAL ascent_traj_disp_mainbox IS ascent_traj_disp:ADDVLAYOUT().
	SET ascent_traj_disp_mainbox:STYLE:ALIGN TO "Center".
	SET ascent_traj_disp_mainbox:STYLe:WIDTH TO ascent_traj_disp:STYLE:WIDTH.
	SET ascent_traj_disp_mainbox:STYLe:HEIGHT TO ascent_traj_disp:STYLE:HEIGHT - 22.
	
	GLOBAL ascent_traj_disp_orbiter_box IS ascent_traj_disp_mainbox:ADDVLAYOUT().
	SET ascent_traj_disp_orbiter_box:STYLE:ALIGN TO "Center".
	SET ascent_traj_disp_orbiter_box:STYLe:WIDTH TO 1.
	SET ascent_traj_disp_orbiter_box:STYLe:HEIGHT TO 1.
	
	GLOBAL ascent_traj_disp_orbiter IS ascent_traj_disp_orbiter_box:ADDLABEL().
	SET ascent_traj_disp_orbiter:IMAGE TO "Shuttle_OPS1/src/gui_images/traj_pos_bug.png".
	SET ascent_traj_disp_orbiter:STYLe:WIDTH TO 12.
	
	local shut_bug_pos is set_ascent_traj_disp_pos(v(ascent_traj_disp_x_convert(0),ascent_traj_disp_y_convert(0), 0), 5).
	
	SET ascent_traj_disp_orbiter:STYLE:margin:v to shut_bug_pos[1].
	SET ascent_traj_disp_orbiter:STYLE:margin:h to shut_bug_pos[0].
	
	GLOBAL ascent_traj_disp_pred_box IS ascent_traj_disp_mainbox:ADDVLAYOUT().
	SET ascent_traj_disp_pred_box:STYLE:ALIGN TO "Center".
	SET ascent_traj_disp_pred_box:STYLe:WIDTH TO 1.
	SET ascent_traj_disp_pred_box:STYLe:HEIGHT TO 1.
	
	GLOBAL ascent_traj_disp_pred_bug_ IS ascent_traj_disp_pred_box:ADDLABEL().
	SET ascent_traj_disp_pred_bug_:IMAGE TO "Shuttle_OPS1/src/gui_images/traj_pred_bug.png".
	SET ascent_traj_disp_pred_bug_:STYLe:WIDTH TO 10.
	
	SET ascent_traj_disp_pred_bug_:STYLE:margin:v to shut_bug_pos[1] - 3.
	SET ascent_traj_disp_pred_bug_:STYLE:margin:h to shut_bug_pos[0].
	
	main_ascent_gui:addspacing(6).
	
	GLOBAL ascent_msg_scroll_box IS main_ascent_gui:addvlayout().
	SET ascent_msg_scroll_box:STYLE:WIDTH TO main_ascent_gui_width - 16.
	SET ascent_msg_scroll_box:STYLE:HEIGHT TO 80.
	SET ascent_msg_scroll_box:STYLE:ALIGN TO "center".
	
	global msgscroll is ascent_msg_scroll_box:addscrollbox().
	set msgscroll:valways to true.
	set msgscroll:style:margin:h to 0.
	set msgscroll:style:margin:v to 0.
	
	main_ascent_gui:SHOW().
	
}


FUNCTION is_dap_css {
	return (dap_b:VALUE = "CSS").
}

FUNCTION is_dap_auto {
	return (dap_b:VALUE = "AUTO").
}

FUNCTION close_all_GUIs{
	CLEARGUIS().
}

function ascent_add_scroll_msg {
	parameter msg.
	parameter clear_all is false.
	
	if (clear_all AND msgscroll:widgets:LENGTH > 0) {
		msgscroll:widgets[0]:dispose().
	}
	
	local newlab is msgscroll:addlabel(msg).
	set newlab:style:margin:v to -2.
	
	set msgscroll:position to v(0,1000,0).

}

FUNCTION clear_ascent_traj_data {
	ascent_traj_disp_overlaiddata:clear().
}

function enable_box_widgets {
	parameter containerbox.
	parameter visible.
	
	for w in containerbox:widgets {
		if (visible) {
			w:show().
		} else {
			w:hide().
		}
	}

}

function make_ascent_traj1_disp {

	set ascent_traj_disp_counter to 1.
	
	clear_ascent_traj_data().
	
	local text_ht is ascent_traj_disp_titlebox:style:height*0.75.
	set ascent_traj_disp_title:text to "<b><size=" + text_ht + ">XXXXXX TRAJ X</size></b>".
	
	set ascent_traj_disp_mainbox:style:BG to "Shuttle_OPS1/src/gui_images/ascent_traj1_bg.png".
	
	GLOBAL ascent_traj_disp_upperdatabox IS ascent_traj_disp_overlaiddata:ADDHLAYOUT().
	
	SET ascent_traj_disp_upperdatabox:STYLE:WIDTH TO 125.
    SET ascent_traj_disp_upperdatabox:STYLE:HEIGHT TO 30.
	set ascent_traj_disp_upperdatabox:style:margin:h to 0.
	set ascent_traj_disp_upperdatabox:style:margin:v to 0.
	
	make_ascent_cutv_slider(ascent_traj_disp_upperdatabox).
	
	enable_box_widgets(cutv_sliderbox, false).
	
	
	GLOBAL ascent_traj_disp_main_data_box IS ascent_traj_disp_overlaiddata:ADDHLAYOUT().
	SET ascent_traj_disp_main_data_box:STYLE:WIDTH TO ascent_traj_disp:STYLE:WIDTH.
    SET ascent_traj_disp_main_data_box:STYLE:HEIGHT TO 350.
	
	GLOBAL ascent_traj_disp_leftdatabox IS ascent_traj_disp_main_data_box:ADDVLAYOUT().
	SET ascent_traj_disp_leftdatabox:STYLE:ALIGN TO "left".
	SET ascent_traj_disp_leftdatabox:STYLE:WIDTH TO 180.
    SET ascent_traj_disp_leftdatabox:STYLE:HEIGHT TO 300.
	set ascent_traj_disp_leftdatabox:style:margin:h to 12.
	set ascent_traj_disp_leftdatabox:style:margin:v to 10.
	
	
	GLOBAL ascent_traj_disp_cont_abort_box IS ascent_traj_disp_leftdatabox:ADDVLAYOUT().
	SET ascent_traj_disp_cont_abort_box:STYLE:ALIGN TO "right".
	SET ascent_traj_disp_cont_abort_box:STYLE:WIDTH TO 130.
    SET ascent_traj_disp_cont_abort_box:STYLE:HEIGHT TO 50.
	set ascent_traj_disp_cont_abort_box:style:margin:h to 60.
	
	GLOBAL ascent_traj_cont_abort1 IS ascent_traj_disp_cont_abort_box:ADDLABEL("CONT ABORT").
	set ascent_traj_cont_abort1:style:margin:v to -4.
	GLOBAL ascent_traj_cont_abort2 IS ascent_traj_disp_cont_abort_box:ADDLABEL(" 2EO XXXXX").
	set ascent_traj_cont_abort2:style:margin:v to -4.
	GLOBAL ascent_traj_cont_abort3 IS ascent_traj_disp_cont_abort_box:ADDLABEL(" 3EO XXXXX").
	set ascent_traj_cont_abort3:style:margin:v to -4.
	
	GLOBAL ascent_trajleftdata1 IS ascent_traj_disp_leftdatabox:ADDLABEL("Ḣ   xxxxxx").
	set ascent_trajleftdata1:style:margin:v to -4.
	GLOBAL ascent_trajleftdata2 IS ascent_traj_disp_leftdatabox:ADDLABEL("").
	set ascent_trajleftdata2:style:margin:v to -4.
	GLOBAL ascent_trajleftdata3 IS ascent_traj_disp_leftdatabox:ADDLABEL("R  xxxxxx").
	set ascent_trajleftdata3:style:margin:v to -4.
	GLOBAL ascent_trajleftdata4 IS ascent_traj_disp_leftdatabox:ADDLABEL("P xxxxxx").
	set ascent_trajleftdata4:style:margin:v to -4.
	GLOBAL ascent_trajleftdata5 IS ascent_traj_disp_leftdatabox:ADDLABEL("Y xxxxxx").
	set ascent_trajleftdata5:style:margin:v to -4.
	GLOBAL ascent_trajleftdata6 IS ascent_traj_disp_leftdatabox:ADDLABEL("T xxxxxx").
	set ascent_trajleftdata6:style:margin:v to -4.
	
	
	GLOBAL ascent_traj_disp_centredatabox IS ascent_traj_disp_main_data_box:ADDVLAYOUT().
	SET ascent_traj_disp_centredatabox:STYLE:ALIGN TO "left".
	SET ascent_traj_disp_centredatabox:STYLE:WIDTH TO 150.
    SET ascent_traj_disp_centredatabox:STYLE:HEIGHT TO 300.
	set ascent_traj_disp_centredatabox:style:margin:h to 0.
	set ascent_traj_disp_centredatabox:style:margin:v to 0.
	
	ascent_traj_disp_centredatabox:addspacing(200).
	
	GLOBAL ascent_traj_disp_droop_box IS ascent_traj_disp_centredatabox:ADDVLAYOUT().
	SET ascent_traj_disp_droop_box:STYLE:WIDTH TO 125.
    SET ascent_traj_disp_droop_box:STYLE:HEIGHT TO 115.
	
	GLOBAL ascent_traj_disp_centredata1 IS ascent_traj_disp_droop_box:ADDLABEL("DROOP ALT XXX").
	set ascent_traj_disp_centredata1:style:margin:v to -4.
	SET ascent_traj_disp_centredata1:STYLE:ALIGN TO "center".
	GLOBAL ascent_traj_disp_centredata2 IS ascent_traj_disp_droop_box:ADDLABEL("<color=#" + guitextyellowhex + ">DROOP ENGAGED</color>").
	set ascent_traj_disp_centredata2:style:margin:v to -4.
	SET ascent_traj_disp_centredata2:STYLE:ALIGN TO "center".
	
	enable_box_widgets(ascent_traj_disp_droop_box, false).
	
	
	GLOBAL ascent_traj_disp_rightdatabox IS ascent_traj_disp_main_data_box:ADDHLAYOUT().
	SET ascent_traj_disp_rightdatabox:STYLE:ALIGN TO "left".
	SET ascent_traj_disp_rightdatabox:STYLE:WIDTH TO 180.
    SET ascent_traj_disp_rightdatabox:STYLE:HEIGHT TO 300.
	set ascent_traj_disp_rightdatabox:style:margin:h to 40.
	set ascent_traj_disp_rightdatabox:style:margin:v to 2.
	
	make_g_slider(ascent_traj_disp_rightdatabox, 160).
	
	GLOBAL ascent_traj_disp_rightdatabox2 IS ascent_traj_disp_rightdatabox:ADDVLAYOUT().
	SET ascent_traj_disp_rightdatabox2:STYLE:ALIGN TO "left".
	SET ascent_traj_disp_rightdatabox2:STYLE:WIDTH TO 125.
    SET ascent_traj_disp_rightdatabox2:STYLE:HEIGHT TO 300.
	set ascent_traj_disp_rightdatabox2:style:margin:h to 5.
	set ascent_traj_disp_rightdatabox2:style:margin:v to 10.
	
	GLOBAL ascent_traj_disp_upfg_box IS ascent_traj_disp_rightdatabox2:ADDVLAYOUT().
	SET ascent_traj_disp_upfg_box:STYLE:ALIGN TO "right".
	SET ascent_traj_disp_upfg_box:STYLE:WIDTH TO 125.
    SET ascent_traj_disp_upfg_box:STYLE:HEIGHT TO 1.
	
	GLOBAL ascent_traj_disp_upfg_box2 IS ascent_traj_disp_upfg_box:ADDVLAYOUT().
	SET ascent_traj_disp_upfg_box2:STYLE:ALIGN TO "right".
	SET ascent_traj_disp_upfg_box2:STYLE:WIDTH TO 125.
    SET ascent_traj_disp_upfg_box2:STYLE:HEIGHT TO 115.
	
	GLOBAL ascent_trajupfgdata1 IS ascent_traj_disp_upfg_box2:ADDLABEL("TGO  xxxxxx").
	set ascent_trajupfgdata1:style:margin:v to -4.
	GLOBAL ascent_trajupfgdata2 IS ascent_traj_disp_upfg_box2:ADDLABEL("VGO  xxxxxx").
	set ascent_trajupfgdata2:style:margin:v to -4.
	//GLOBAL ascent_trajupfgdata3 IS ascent_traj_disp_upfg_box2:ADDLABEL("T_C  xxxxxx").
	//set ascent_trajupfgdata3:style:margin:v to -4.
	
	enable_box_widgets(ascent_traj_disp_upfg_box2, false).
	
	ascent_traj_disp_rightdatabox2:addspacing(150).
	
	GLOBAL ascent_trajrightdata4 IS ascent_traj_disp_rightdatabox2:ADDLABEL("THROT xxxxxx").
	set ascent_trajrightdata4:style:margin:v to -4.
	GLOBAL ascent_trajrightdata5 IS ascent_traj_disp_rightdatabox2:ADDLABEL("PROP xxxxxx").
	set ascent_trajrightdata5:style:margin:v to -4.
	
	GLOBAL ascent_traj_disp_engout_box IS ascent_traj_disp_rightdatabox2:ADDVLAYOUT().
	SET ascent_traj_disp_engout_box:STYLE:ALIGN TO "right".
	SET ascent_traj_disp_engout_box:STYLE:WIDTH TO 125.
    SET ascent_traj_disp_engout_box:STYLE:HEIGHT TO 115.
	set ascent_traj_disp_engout_box:style:margin:h to 0.
	set ascent_traj_disp_engout_box:style:margin:v to 45.
	
	GLOBAL ascent_traj_engout_data is LIST().
	
	
	
}

function ascent_traj_add_engout {
	parameter engout_vi.
	
	local eng_out_n is 1 + ascent_traj_engout_data:LENGTH.
	
	local new_engout_text is ascent_traj_disp_engout_box:ADDLABEL(eng_out_n + " EO VI " + round(engout_vi, 0)).
	set new_engout_text:style:margin:v to -4.
	set new_engout_text:style:margin:h to -4.
	
	ascent_traj_engout_data:ADD(new_engout_text).
	
}

function make_ascent_cutv_slider {
	parameter container_box.
	
	GLOBAL cutv_sliderbox IS container_box:ADDHLAYOUT().
	SET cutv_sliderbox:STYLe:HEIGHT TO 40.
	SET cutv_sliderbox:STYLe:width TO 400.
	set cutv_sliderbox:style:margin:h to 80.
	set cutv_sliderbox:style:margin:v to 10.
	
	GLOBAL cutv_tgt_bug_box IS cutv_sliderbox:ADDVLAYOUT().
	SET cutv_tgt_bug_box:STYLE:ALIGN TO "Center".
	SET cutv_tgt_bug_box:STYLe:WIDTH TO 1.
	SET cutv_tgt_bug_box:STYLe:HEIGHT TO 1.
	
	GLOBAL cutv_tgt_bug_ IS cutv_tgt_bug_box:ADDLABEL().
	SET cutv_tgt_bug_:IMAGE TO "Shuttle_OPS1/src/gui_images/cutoff_vel_bug.png".
	SET cutv_tgt_bug_:STYLe:WIDTH TO 25.
	SET cutv_tgt_bug_:STYLe:HEIGHT TO 25.
	
	set cutv_tgt_bug_:style:margin:h to 4.
	set cutv_tgt_bug_:style:margin:v to 5.
	
	SET main_ascent_gui:skin:horizontalslider:bg TO "Shuttle_OPS1/src/gui_images/cutv_slider_bg.png".
	set main_ascent_gui:skin:horizontalsliderthumb:BG to "Shuttle_OPS1/src/gui_images/hslider_thumb.png".
	set main_ascent_gui:skin:horizontalsliderthumb:HEIGHT to 11.
	set main_ascent_gui:skin:horizontalsliderthumb:WIDTH to 16.
	set main_ascent_gui:skin:horizontalsliderthumb:margin:v to -12.
	
	GLOBAL cutv_slider is cutv_sliderbox:addhslider(7,7,8).
	SET cutv_slider:style:vstretch to false.
	SET cutv_slider:style:hstretch to false.
	SET cutv_slider:STYLE:WIDTH TO 335.
	SET cutv_slider:STYLE:HEIGHT TO 20.

}

function ascent_gui_set_cutv_indicator {
	parameter cutv.

	set cutv_tgt_bug_:style:margin:h to 4 + (cutv/1000 - 7)*320.

}

function make_rtls_cutv_slider {
	parameter container_box.
	
	GLOBAL rtls_cutv_sliderbox IS container_box:ADDHLAYOUT().
	SET rtls_cutv_sliderbox:STYLe:HEIGHT TO 40.
	SET rtls_cutv_sliderbox:STYLe:width TO 500.
	set rtls_cutv_sliderbox:style:margin:h to 30.
	set rtls_cutv_sliderbox:style:margin:v to 10.
	
	GLOBAL cutv_tgt_bug_box IS rtls_cutv_sliderbox:ADDVLAYOUT().
	SET cutv_tgt_bug_box:STYLE:ALIGN TO "Center".
	SET cutv_tgt_bug_box:STYLe:WIDTH TO 1.
	SET cutv_tgt_bug_box:STYLe:HEIGHT TO 1.
	
	GLOBAL rtls_cutv_tgt_bug_ IS cutv_tgt_bug_box:ADDLABEL().
	SET rtls_cutv_tgt_bug_:IMAGE TO "Shuttle_OPS1/src/gui_images/cutoff_vel_bug.png".
	SET rtls_cutv_tgt_bug_:STYLe:WIDTH TO 25.
	SET rtls_cutv_tgt_bug_:STYLe:HEIGHT TO 25.
	
	set rtls_cutv_tgt_bug_:style:margin:h to 4.
	set rtls_cutv_tgt_bug_:style:margin:v to 5.
	
	SET main_ascent_gui:skin:horizontalslider:bg TO "Shuttle_OPS1/src/gui_images/rtls_cutv_slider_bg.png".
	set main_ascent_gui:skin:horizontalsliderthumb:BG to "Shuttle_OPS1/src/gui_images/hslider_thumb.png".
	set main_ascent_gui:skin:horizontalsliderthumb:HEIGHT to 11.
	set main_ascent_gui:skin:horizontalsliderthumb:WIDTH to 16.
	set main_ascent_gui:skin:horizontalsliderthumb:margin:v to -12.
	
	GLOBAL rtls_cutv_slider is rtls_cutv_sliderbox:addhslider(1.5,2.5,1.5).
	SET rtls_cutv_slider:style:vstretch to false.
	SET rtls_cutv_slider:style:hstretch to false.
	SET rtls_cutv_slider:STYLE:WIDTH TO 435.
	SET rtls_cutv_slider:STYLE:HEIGHT TO 20.

}

function rtls_gui_set_cutv_indicator {
	parameter cutv.

	set rtls_cutv_tgt_bug_:style:margin:h to 4 + ( 1 - (cutv/1000 - 1.5))*420.

}

function make_g_slider {
	parameter container_box.
	parameter v_margin.
	
	SET main_ascent_gui:skin:verticalslider:bg TO "Shuttle_OPS1/src/gui_images/g_slider_bg2.png".
	set main_ascent_gui:skin:verticalsliderthumb:BG to "Shuttle_OPS1/src/gui_images/vslider_thumb.png".
	set main_ascent_gui:skin:verticalsliderthumb:HEIGHT to 15.
	set main_ascent_gui:skin:verticalsliderthumb:WIDTH to 11.
	set main_ascent_gui:skin:verticalsliderthumb:margin:h to 22.
	
	GLOBAL g_sliderbox IS container_box:ADDHLAYOUT().
	set g_sliderbox:style:margin:v to v_margin.
	SET g_sliderbox:STYLe:WIDTH TO 40.
	GLOBAL g_slider is g_sliderbox:addvslider(1,3.4,0.6).
	SET g_slider:STYLE:ALIGN TO "Center".
	SET g_slider:style:vstretch to false.
	SET g_slider:style:hstretch to false.
	SET g_slider:STYLE:WIDTH TO 27.
	SET g_slider:STYLE:HEIGHT TO 100.
	
}

function update_g_slider {
	parameter g_val.
	
	SET g_slider:VALUE TO CLAMP(g_val,g_slider:MIN,g_slider:MAX).
	
	if (g_val > 3.1) {
		set main_ascent_gui:skin:verticalsliderthumb:BG to "Shuttle_OPS1/src/gui_images/vslider_thumb_yellow.png".
	} else {
		set main_ascent_gui:skin:verticalsliderthumb:BG to "Shuttle_OPS1/src/gui_images/vslider_thumb.png".
	}

}

FUNCTION update_traj_disp_title {
	PARAMETER disp_counter.
	
	//based on abort modes
	LOCAL str is "ASCENT".
	IF (abort_modes["triggered"]) {
		IF (abort_modes["ATO"]["triggered"] = TRUE) {
			SET str TO "   ATO".
		} ELSE IF (abort_modes["TAL"]["triggered"] = TRUE) {
			SET str TO "   TAL".
		} ELSE IF (abort_modes["RTLS"]["triggered"] = TRUE) {
			SET str TO "  RTLS".
		}
	}
	
	local text_ht is ascent_traj_disp_titlebox:style:height*0.75.
	set ascent_traj_disp_title:text to "<b><size=" + text_ht + ">" + str + " TRAJ " + disp_counter + "</size></b>".

}

function make_ascent_traj2_disp {
	set ascent_traj_disp_counter to 2.
	
	set ascent_traj_disp_mainbox:style:BG to "Shuttle_OPS1/src/gui_images/ascent_traj2_bg.png".
	
	enable_box_widgets(cutv_sliderbox, true).
	enable_box_widgets(ascent_traj_disp_droop_box, true).
	enable_box_widgets(ascent_traj_disp_upfg_box2, true).
	
	//ADD stuff to ascent_traj_disp_overlaiddata
}

//
function make_rtls_traj2_disp {
	
	local text_ht is ascent_traj_disp_titlebox:style:height*0.75.
	set ascent_traj_disp_title:text to "<b><size=" + text_ht + ">XXXXXX TRAJ X</size></b>".
	
	set ascent_traj_disp_mainbox:style:BG to "Shuttle_OPS1/src/gui_images/rtls_traj2_bg.png".
	
	clear_ascent_traj_data().
	
	GLOBAL rtls_traj_disp_upperdatabox IS ascent_traj_disp_overlaiddata:ADDHLAYOUT().
	
	SET rtls_traj_disp_upperdatabox:STYLE:WIDTH TO 300.
    SET rtls_traj_disp_upperdatabox:STYLE:HEIGHT TO 30.
	set rtls_traj_disp_upperdatabox:style:margin:h to 0.
	set rtls_traj_disp_upperdatabox:style:margin:v to 0.
	
	make_rtls_cutv_slider(rtls_traj_disp_upperdatabox).
	
	GLOBAL rtls_traj_disp_leftdatabox IS ascent_traj_disp_overlaiddata:ADDVLAYOUT().
	SET rtls_traj_disp_leftdatabox:STYLE:ALIGN TO "left".
	SET rtls_traj_disp_leftdatabox:STYLE:WIDTH TO 125.
    SET rtls_traj_disp_leftdatabox:STYLE:HEIGHT TO 115.
	set rtls_traj_disp_leftdatabox:style:margin:h to 80.
	set rtls_traj_disp_leftdatabox:style:margin:v to 12.
	
	GLOBAL rtls_trajleftdata1 IS rtls_traj_disp_leftdatabox:ADDLABEL("Ḣ   xxxxxx").
	set rtls_trajleftdata1:style:margin:v to -4.
	GLOBAL rtls_trajleftdata2 IS rtls_traj_disp_leftdatabox:ADDLABEL("THR   xxxxxx").
	set rtls_trajleftdata2:style:margin:v to -4.
	GLOBAL rtls_trajleftdata3 IS rtls_traj_disp_leftdatabox:ADDLABEL("PROP xxxxxx").
	set rtls_trajleftdata3:style:margin:v to -4.
	
	GLOBAL rtls_trajleftdata4 IS rtls_traj_disp_leftdatabox:ADDLABEL("").
	set rtls_trajleftdata4:style:margin:v to -4.
	
	GLOBAL rtls_trajleftdata5 IS rtls_traj_disp_leftdatabox:ADDLABEL("TGO  xxxxxx").
	set rtls_trajleftdata5:style:margin:v to -4.
	GLOBAL rtls_trajleftdata6 IS rtls_traj_disp_leftdatabox:ADDLABEL("VGO  xxxxxx").
	set rtls_trajleftdata6:style:margin:v to -4.
	GLOBAL rtls_trajleftdata7 IS rtls_traj_disp_leftdatabox:ADDLABEL("T_C  xxxxxx").
	set rtls_trajleftdata7:style:margin:v to -4.
	
	
	GLOBAL rtls_traj_disp_rightdatabox IS ascent_traj_disp_overlaiddata:ADDHLAYOUT().
	SET rtls_traj_disp_rightdatabox:STYLE:ALIGN TO "left".
	SET rtls_traj_disp_rightdatabox:STYLE:WIDTH TO 125.
    SET rtls_traj_disp_rightdatabox:STYLE:HEIGHT TO 115.
	set rtls_traj_disp_rightdatabox:style:margin:h to 385.
	set rtls_traj_disp_rightdatabox:style:margin:v to 45.
	
	make_g_slider(rtls_traj_disp_rightdatabox).
	
	GLOBAL rtls_traj_disp_rightattbox IS rtls_traj_disp_rightdatabox:ADDVLAYOUT().
	SET rtls_traj_disp_rightattbox:STYLE:ALIGN TO "left".
	SET rtls_traj_disp_rightattbox:STYLE:WIDTH TO 125.
    SET rtls_traj_disp_rightattbox:STYLE:HEIGHT TO 115.
	set rtls_traj_disp_rightattbox:style:margin:h to 10.
	set rtls_traj_disp_rightattbox:style:margin:v to 12.
	
	GLOBAL rtls_trajrightdata1 IS rtls_traj_disp_rightattbox:ADDLABEL("R  xxxxxx").
	set rtls_trajrightdata1:style:margin:v to -4.
	GLOBAL rtls_trajrightdata2 IS rtls_traj_disp_rightattbox:ADDLABEL("P xxxxxx").
	set rtls_trajrightdata2:style:margin:v to -4.
	GLOBAL rtls_trajrightdata3 IS rtls_traj_disp_rightattbox:ADDLABEL("Y xxxxxx").
	set rtls_trajrightdata3:style:margin:v to -4.
	GLOBAL rtls_trajrightdata4 IS rtls_traj_disp_rightattbox:ADDLABEL("T xxxxxx").
	set rtls_trajrightdata4:style:margin:v to -4.
	
}

function update_att_angles {
	parameter gui_data.
	parameter p_text_handle.
	parameter r_text_handle.
	parameter y_text_handle.
	parameter t_text_handle.
	
	
	local r_delta is round(gui_data["r_delta"],0).
	local r_delta_text_color is guitextgreenhex.
	if (abs(r_delta) > 2) {
		set r_delta_text_color to guitextyellowhex.
	}
	local rolstr is "<color=#" + r_delta_text_color + ">R  ".
	if (r_delta > 0) {
		set rolstr to rolstr + "R".
	} else {
		set rolstr to rolstr + "L".
	}
	set rolstr to rolstr + abs(r_delta) + "</color>".
	set r_text_handle:text to rolstr. 
	
	local p_delta is round(gui_data["p_delta"],0).
	local p_delta_text_color is guitextgreenhex.
	if (abs(p_delta) > 2) {
		set p_delta_text_color to guitextyellowhex.
	}
	local pchstr is "<color=#" + p_delta_text_color + ">P  ".
	if (p_delta > 0) {
		set pchstr to pchstr + "U".
	} else {
		set pchstr to pchstr + "D".
	}
	set pchstr to pchstr + abs(p_delta) + "</color>".
	set p_text_handle:text to pchstr. 
	
	local y_delta is round(gui_data["y_delta"],0).
	local y_delta_text_color is guitextgreenhex.
	if (abs(y_delta) > 2) {
		set y_delta_text_color to guitextyellowhex.
	}
	local yawstr is "<color=#" + y_delta_text_color + ">Y  ".
	if (y_delta > 0) {
		set yawstr to yawstr + "R".
	} else {
		set yawstr to yawstr + "L".
	}
	
	set yawstr to yawstr + abs(y_delta) + "</color>".
	set y_text_handle:text to yawstr. 
	
	local t_delta is round(gui_data["t_delta"],0).
	local t_delta_text_color is guitextgreenhex.
	if (abs(t_delta) > 2) {
		set t_delta_text_color to guitextyellowhex.
	}
	local thrstr is "<color=#" + t_delta_text_color + ">T  " + t_delta + "</color>".
	set t_text_handle:text to thrstr.
	
}

function update_ascent_traj_disp {
	parameter gui_data.
	
	if (ascent_traj_disp_counter = 1 AND gui_data["ve"] >= 1200) {
		make_ascent_traj2_disp().
	}
	
	update_traj_disp_title(ascent_traj_disp_counter).

	SET ascent_traj_disp_clock:text TO "MET " + sectotime_simple(MISSIONTIME, true).
	
	set ascent_trajleftdata1:text to "Ḣ   " + round(gui_data["hdot"], 0). 
	
	update_att_angles(
					gui_data,
					ascent_trajleftdata4,
					ascent_trajleftdata3,
					ascent_trajleftdata5,
					ascent_trajleftdata6
	).
	
	

	local upfg_text_color is guitextgreenhex.
	if (NOT gui_data["converged"]) {
		set upfg_text_color to guitextyellowhex.
	}
	
	LOCAL tc_sign IS " ".
	IF (gui_data["rtls_tc"] <= -1) {
		SET tc_sign TO "-".
	}

	set ascent_trajupfgdata1:text to "<color=#" + upfg_text_color + ">TGO " + sectotime_simple(gui_data["tgo"]) + "</color>". 
	set ascent_trajupfgdata2:text to "<color=#" + upfg_text_color + ">VGO  " + round(gui_data["vgo"], 0) + "</color>". 
	//set ascent_trajupfgdata3:text to "<color=#" + upfg_text_color + ">T_C " + tc_sign + sectotime_simple(ABS(gui_data["rtls_tc"])) + "</color>". 
	
	update_g_slider(gui_data["twr"]).
	
	set ascent_trajrightdata4:text to "PROP " + round(gui_data["et_prop"],0). 
	set ascent_trajrightdata5:text to "THR  " + round(gui_data["ssme_thr"], 0). 
	
	SET cutv_slider:VALUE TO CLAMP(gui_data["vi"]/1000,cutv_slider:MIN,cutv_slider:MAX).
	
	local xval is gui_data["ve"].
	local xpredval is gui_data["pred_ve"].
	
	if (ascent_traj_disp_counter = 2) {
		set xval to gui_data["vi"].
		set xpredval to gui_data["pred_vi"].
	}
	
	local yval is gui_data["alt"] / gui_data["alt_ref"].
	local ypredval is gui_data["pred_alt"] / gui_data["alt_ref"].
	
	local shut_bug_pos is set_ascent_traj_disp_pos(v(ascent_traj_disp_x_convert(xval),ascent_traj_disp_y_convert(yval), 0), 5).
	
	SET ascent_traj_disp_orbiter:STYLE:margin:v to shut_bug_pos[1].
	SET ascent_traj_disp_orbiter:STYLE:margin:h to shut_bug_pos[0].
	
	local shut_pred_pos is set_ascent_traj_disp_pos(v(ascent_traj_disp_x_convert(xpredval),ascent_traj_disp_y_convert(ypredval), 0), 5).
	SET ascent_traj_disp_pred_bug_:STYLE:margin:v to shut_pred_pos[1] - 3.
	SET ascent_traj_disp_pred_bug_:STYLE:margin:h to shut_pred_pos[0].

}


function update_rtls_traj_disp {
	parameter gui_data.
	
	update_traj_disp_title(ascent_traj_disp_counter).

	SET ascent_traj_disp_clock:text TO "MET " + sectotime_simple(gui_data["met"], true).
	
	set rtls_trajleftdata1:text to "Ḣ   " + round(gui_data["hdot"], 0). 
	
	set rtls_trajleftdata3:text to "PROP " + round(gui_data["et_prop"],0). 
	set rtls_trajleftdata2:text to "THR  " + round(gui_data["ssme_thr"], 0). 

	local upfg_text_color is guitextgreenhex.
	if (NOT gui_data["converged"]) {
		set upfg_text_color to guitextyellowhex.
	}
	
	LOCAL tc_sign IS " ".
	IF (gui_data["rtls_tc"] <= -1) {
		SET tc_sign TO "-".
	}

	set rtls_trajleftdata5:text to "<color=#" + upfg_text_color + ">TGO " + sectotime_simple(gui_data["tgo"]) + "</color>". 
	set rtls_trajleftdata6:text to "<color=#" + upfg_text_color + ">VGO  " + round(gui_data["vgo"], 0) + "</color>". 
	set rtls_trajleftdata7:text to "<color=#" + guitextgreenhex + ">T_C " + tc_sign + sectotime_simple(ABS(gui_data["rtls_tc"])) + "</color>". 
	
	update_att_angles(
					gui_data,
					rtls_trajrightdata2,
					rtls_trajrightdata1,
					rtls_trajrightdata3,
					rtls_trajrightdata4
	).

	update_g_slider(gui_data["twr"]).
	
	SET rtls_cutv_slider:VALUE TO CLAMP(-SIGN(gui_data["dwnrg_ve"]) * gui_data["ve"]/1000,rtls_cutv_slider:MIN,rtls_cutv_slider:MAX).

	rtls_gui_set_cutv_indicator(gui_data["rtls_cutv"]).

	local shut_bug_pos is set_ascent_traj_disp_pos(v(rtls_traj_disp_x_convert(gui_data["dwnrg_ve"]),rtls_traj_disp_y_convert(gui_data["alt"]), 0), 5).
	
	SET ascent_traj_disp_orbiter:STYLE:margin:v to shut_bug_pos[1].
	SET ascent_traj_disp_orbiter:STYLE:margin:h to shut_bug_pos[0].
	
	local shut_pred_pos is set_ascent_traj_disp_pos(v(rtls_traj_disp_x_convert(gui_data["dwnrg_pred_ve"]),rtls_traj_disp_y_convert(gui_data["pred_alt"]), 0), 5).
	SET ascent_traj_disp_pred_bug_:STYLE:margin:v to shut_pred_pos[1] - 3.
	SET ascent_traj_disp_pred_bug_:STYLE:margin:h to shut_pred_pos[0].

}

//rescale redo
function set_ascent_traj_disp_pos {
	parameter bug_pos.
	parameter bias is 0.
	
	local bug_margin is 10.
	
	local bounds_x is list(10, ascent_traj_disp_mainbox:STYLe:WIDTH - 32).
	local bounds_y is list(ascent_traj_disp_mainbox:STYLe:HEIGHT - 29, 0).
	
	//print "calc_x: " + bug_pos:X + " calc_y: " +  + bug_pos:Y  + "  " at (0, 4).
	
	local pos_x is 1.04693*bug_pos:X  - 8.133 + bias.
	local pos_y is 395.55 - 1.1685*bug_pos:Y + bias.
	
	//print "disp_x: " + pos_x + " disp_y: " + pos_y + "  " at (0, 5).
	
	set pos_x to clamp(pos_x, bounds_x[0], bounds_x[1] ).
	set pos_y to clamp(pos_y, bounds_y[0], bounds_y[1]).
	
	//print "disp_x: " + pos_x + " disp_y: " + pos_y + "  " at (0, 6).
	
	return list(pos_x,pos_y).
}

function ascent_traj_disp_x_convert {
	parameter val.
	
	local out is 0.
	
	if (ascent_traj_disp_counter = 1) {
		set out to val*8e-4  + 0.13 .
	} else if (ascent_traj_disp_counter = 2) {
		set out to val^2*1.3e-08 + val*5e-5 + 0.05  .
	}
	
	return out * 380 .
}

function ascent_traj_disp_y_convert {
	parameter val.
	
	local out is 0.
	
	if (ascent_traj_disp_counter = 1) {
		set out to val * 0.729 + 0.13 .
	} else if (ascent_traj_disp_counter = 2) {
		set out to val * 0.656168 - 0.05.
	}

	return 50 + 300 * out .
}	


function rtls_traj_disp_x_convert {
	parameter val.
	
	local par is val*3.28084.
	
	local out is  ((par + 8000.0)/18000*0.8 + 0.1)*512.
	
	return out.
}

function rtls_traj_disp_y_convert {
	parameter val.
	
	local par is val*3280.84.
	
	local out is 512.0 - ((par - 150000)/450000 * 0.7 + 0.2) * 512.

	return (425 - out)*300/275 + 50.
}	
