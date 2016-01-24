
"delete" call OO_fnc_inidbi;

private ["_cities_status","_fobs","_name","_city_status","_array_ho","_data","_ho_markers","_array_cache","_fobs","_array_veh","_cargo","_array_obj","_marker","_lereste","_nb_cities_array","_step","_temp_save","_data_units"];

hint "saving...";
[[8],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = true;

["write", ["mission_Param", "date", date]] call OO_fnc_inidbi;

for "_i" from 0 to (count btc_city_all - 1) do {
	private "_s";
	_s = [_i] spawn btc_fnc_city_de_activate;
	waitUntil {scriptDone _s};
};
hint "saving...2";
//City status
_cities_status = [];
_nb_cities_data_units = [];
{
	//[151,false,false,true,false,false,[]]
	_city_status = [];
	_city_status pushBack (_x getVariable "id");

	//_city_status pushBack (_x getVariable "name");

	_city_status pushBack (_x getVariable "initialized");

	_city_status pushBack (_x getVariable "spawn_more");
	_city_status pushBack (_x getVariable "occupied");

	_data_units = +(_x getVariable "data_units");
	{
		if ((_x select 0) isEqualTo 3) then {
			player sideChat str(_x select 7);
			player sideChat str(getPos (_x select 7));
			_x set [7,getPos (_x select 7)];
		};
	} forEach _data_units;
	_nb_cities_data_units pushBack ([_data_units,"environement",format ["city_%1_data_units",(_city_status select 0)]] call btc_fnc_db_save_array);

	_city_status pushBack (_x getVariable ["has_ho",false]);
	_city_status pushBack (_x getVariable ["ho_units_spawned",false]);
	_city_status pushBack (_x getVariable ["ieds",[]]);

	_cities_status pushBack _city_status;
	//diag_log format ["SAVE: %1 - %2",(_x getVariable "id"),(_x getVariable "occupied")];
} foreach btc_city_all;
["write", ["environement", "nb_cities_data_units", _nb_cities_data_units]] call OO_fnc_inidbi;

cities_status = +_cities_status;
_nb_cities_status = [[_cities_status,"environement","cities_status"] call btc_fnc_db_save_array];
["write", ["environement", "nb_cities_status", _nb_cities_status]] call OO_fnc_inidbi;


//HIDEOUT
_array_ho = [];
{
	_data = [];
	_data pushBack (getPos _x);
	_data pushBack (_x getVariable ["id",0]);
	_data pushBack (_x getVariable ["rinf_time",0]);
	_data pushBack (_x getVariable ["cap_time",0]);

	_ho_markers = [];
	{
		_marker = [];
		_marker pushback (getMarkerPos _x);
		_marker pushback (markerText _x);
		_ho_markers pushback _marker;
	} foreach (_x getVariable ["markers",[]]);
	_data pushback (_ho_markers);
	diag_log format ["HO %1 DATA %2",_x,_data];
	_array_ho pushBack _data;
} foreach btc_hideouts;
["write", ["environement", "ho", _array_ho]] call OO_fnc_inidbi;

["write", ["environement", "ho_sel", (btc_hq getVariable ["info_hideout",objNull]) getVariable ["id",0] ]] call OO_fnc_inidbi;

//CACHE
_array_cache = [];
_array_cache pushback (getposATL btc_cache_obj);
_array_cache pushback (btc_cache_n);
_array_cache pushback (btc_cache_info);
_cache_markers = [];
{
	_data = [];
	_data pushback (getMarkerPos _x);
	_data pushback (markerText _x);
	_cache_markers pushBack _data;
} foreach btc_cache_markers;
_array_cache pushback (_cache_markers);
["write", ["environement", "cache", _array_cache]] call OO_fnc_inidbi;

//rep status
["write", ["environement", "rep", btc_global_reputation]] call OO_fnc_inidbi;

//FOBS
_fobs = [];
{
	private "_pos";
	_pos = getMarkerPos _x;
	_fobs pushBack [_x,_pos];
} foreach btc_fobs;
["write", ["base", "fobs", _fobs]] call OO_fnc_inidbi;

//Vehicles status
_array_veh = [];
{
	_data = [];
	_data pushBack (typeOf _x);
	_data pushBack (getPos _x);
	_data pushBack (getDir _x);
	_data pushBack (fuel _x);
	_data pushBack (damage _x);
	_cargo = [];
	{_cargo pushBack (typeOf _x)} foreach (_x getVariable ["cargo",[]]);
	_data pushBack _cargo;
	_array_veh pushBack _data;
	//diag_log format ["VEH %1 DATA %2",_x,_data];
} foreach btc_vehicles;
["write", ["base", "vehs", _array_veh]] call OO_fnc_inidbi;

//Objects status
_array_obj = [];
{
	if (!isNil {_x getVariable "loaded"} || !Alive _x || isNull _x) exitWith {};
	_data = [];
	_data pushBack (typeOf _x);
	_data pushBack (getPosASL _x);
	_data pushBack (getDir _x);
	_cargo = [];
	{_cargo pushBack (typeOf _x)} foreach (_x getVariable ["cargo",[]]);
	_data pushBack _cargo;
	_array_obj pushBack _data;
} foreach btc_log_obj_created;
["write", ["base", "objs", _array_obj]] call OO_fnc_inidbi;

//
hint "saving...3";
[[9],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = false;