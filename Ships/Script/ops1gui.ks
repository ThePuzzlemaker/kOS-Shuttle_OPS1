 clearscreen.
 
 RUNPATH("0:/Libraries/misc_library").	
RUNPATH("0:/Libraries/maths_library").	
RUNPATH("0:/Libraries/navigation_library").	


RUNPATH("0:/Shuttle_OPS1/src/ops1_gui_library.ks").

RUNPATH("0:/Shuttle_OPS1/src/sample_traj_data.ks").

GLOBAL quit_program IS FALSE.

make_main_ascent_gui().


local alt_ is 0.
local vel_ is 0.
local twr is 0.
local vi is 7000.

local sample_data is sample_traj_data().
local sample_data_count is 0.

make_ascent_traj1_disp(7654).

local phase is 1.

when (vel_ > 1215) then {
	make_ascent_traj2_disp().
	set phase to 2.
}

until false {

	//if (ship:control:pilotyaw > 0) {
	//	set sample_data_count to sample_data_count + 2.
	//} else if (ship:control:pilotyaw < 0) {
	//	set sample_data_count to max(0, sample_data_count - 2).
	//}
	
	set twr to twr + 0.05*ship:control:pilotpitch.
	
	set vi to vi + 10*ship:control:pilotyaw.
	
	print "vi " + vi + " " at (0,2).
	
	set alt_ to sample_data[sample_data_count][0].
	set vel_ to sample_data[sample_data_count][1].

	

	LOCAL gui_data IS lexicon(
					"ve", vel_,
					"vi", vi,
					"alt", alt_,
					"twr", twr
	).

	update_ascent_traj_disp(gui_data).

	if (quit_program) {
		BREAK.
	} 

	wait 0.1.
}

close_all_GUIs().