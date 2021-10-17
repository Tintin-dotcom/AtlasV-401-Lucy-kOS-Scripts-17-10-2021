clearscreen.
wait 5.
stage.
lock tval to 0.
lock thrval to 0.
lock inclination to 90.
set runmode to "Liftoff".
set stage2 to "n".

until runmode = "Done" {
	if runmode = "Liftoff" {
		set thrval to thrval + 0.005.
		lock tval to thrval.
		if tval >= 1 {
			wait 0.5.
			stage.
			set runmode to "Ascent".
		}
	}
	if runmode = "Ascent" {
		lock tval to 1.
		turn(inclination).
		if ship:stagedeltav(ship:stagenum):current < 870 and stage2 = "y" and alt:radar > 150000 {
			print "haha".
			lock tval to 0.
			wait 5.
			stage.
			wait 15.
			toggle ag1.
			toggle ag2.
			set runmode to "Done".
		}
	}
	if ship:stagedeltav(ship:stagenum):current < 25 and stage2 = "n" and ship:availablethrust > 1175 {
		print "hehe".
		wait 2.
		stage.
		wait 3.
		stage.
		wait 6.
		stage.
		set stage2 to "y".
	}
	lock throttle to tval.
	
	printVesselStats().
}

function printVesselStats {
	clearscreen.
	print "Telemetry:" at(1, 4).
	print "Altitude above sea level: " + round(ship:altitude) + "m" at(10, 5).
	print "Current apoapsis: " + round(ship:apoapsis) + "m" at (10, 6).
	print "Current periapsis: " + round(ship:periapsis) + "m" at (10, 7).
	print "Orbital velocity: " + round(ship:velocity:orbit:mag * 3.6) + "km/h" at(10, 9).
	print "Stage DeltaV: " + ship:stagedeltav(ship:stagenum):current + "m/s" at (10, 10).
	print "Thrust: " + ship:availablethrust + "kN" at (10, 11). 
}

function turn {
	parameter heading.
	if alt:radar < 500 {
		lock angle to 90.
		lock steering to heading(heading, angle).
	}
	else if alt:radar > 60000 {
		lock steering to heading(heading, 10).
	}
	else{
		lock angle to 100 - 1.13287 * alt:radar^.4.
		lock steering to heading(heading, angle).
	}
}

