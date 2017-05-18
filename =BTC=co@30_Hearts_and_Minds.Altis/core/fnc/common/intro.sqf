
private ["_color","_array"];

_color = [1,0.5,0,1];

_array = [
['\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa',_color, getPos btc_gear_object, 1.1, 1.1, 0, "Arsenal/Re-deploy", 1],
['\A3\Ui_f\data\Logos\a_64_ca.paa',_color, [getPos btc_gear_object select 0,getPos btc_gear_object select 1,(getPos btc_gear_object select 2) + 2], 1.1, 1.1, 0, "", 1],
//['\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa',_color, [getPos btc_create_object select 0,getPos btc_create_object select 1,(getPos btc_create_object select 2) + 5], 0.9, 0.9, 90, "", 1],
['\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa',_color, [getPos btc_create_object select 0,getPos btc_create_object select 1,(getPos btc_create_object select 2) + 2.5], 0.9, 0.9, 0, "", 1],
['\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa',_color, getPos btc_create_object, 0.9, 0.9, 0, "Rearm/Repair and Objects", 1],
['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca',[0.7,0,0,1], getPos btc_veh_10, 1.1, 1.1, 0, "Death From Above", 1],
['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca',[0,0,0.7,1], getPos btc_veh_14, 1.1, 1.1, 0, "Transport Heli", 1],
['\A3\ui_f\data\map\vehicleicons\iconapc_ca',[0.7,0,0,1], getPos btc_veh_1, 1.1, 1.1, 0, "APC", 1],
['\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa',_color, getPos mg2_medbay, 0.9, 0.9, 0, "Medical Bay", 1]
];
if (!isNil "btc_helo_1") then {_array pushBack ['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa',[0,0.7,0,1], getPos mg2_HALOcrate, 1.1, 1.1, 0, "HALO Point", 1];};

[getMarkerPos "btc_base","Welcome to Hearts and Minds soldier ...",40,150,240,0,_array,0] call BIS_fnc_establishingShot;

enableSaving [false,false];
