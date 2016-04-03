private "_obj";
_obj = _this createVehicle [getpos btc_create_object_point select 0,getpos btc_create_object_point select 1,0];
if (((_this select 0) == "B_CargoNet_01_ammo_F") || ((_this select 0) == "Box_NATO_AmmoVeh_F")) then {
	[_obj,500] remoteExec ["btc_fnc_log_set_mass",0];
};
if (((_this select 0) == btc_supplies_mat) || ((_this select 0) == btc_fob_mat)) then {
	[_obj,2000] remoteExec ["btc_fnc_log_set_mass",0];
};
btc_log_obj_created = btc_log_obj_created + [_obj];
btc_curator addCuratorEditableObjects [[_obj], false];