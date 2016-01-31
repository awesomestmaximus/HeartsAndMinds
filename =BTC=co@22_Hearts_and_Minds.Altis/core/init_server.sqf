call compile preprocessFile "core\fnc\city\init.sqf";

if (btc_db_load && isClass(configFile >> "cfgPatches" >> "inidbi2")) then {
	if ("exists" call OO_fnc_inidbi) then {
		call compile preprocessFile "core\fnc\db\load.sqf";
	} else {
		for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};

		[] execVM "core\fnc\cache\init.sqf";

		[] spawn {{waitUntil {!isNull _x};_x addMPEventHandler ["MPKilled", {if (isServer) then {_this call btc_fnc_eh_veh_killed};}];} foreach btc_vehicles;};
	};
} else {
	for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};

	[] execVM "core\fnc\cache\init.sqf";

	[] spawn {{waitUntil {!isNull _x};_x addMPEventHandler ["MPKilled", {if (isServer) then {_this call btc_fnc_eh_veh_killed};}];} foreach btc_vehicles;};
};

[btc_helo_1,30,true] spawn btc_fnc_eh_veh_add_respawn;