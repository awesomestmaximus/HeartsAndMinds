
private ["_lereste","_section","_key","_nb_cities_array","_step","_temp_save"];

_lereste = _this select 0;
_section = _this select 1;
_key = _this select 2;

_step = count _lereste;
_nb_cities_array = 0;

while {!(_lereste isEqualTo [])} do
{
	if (_step isEqualTo 0) exitWith {
		hint "Error Array too big";
		lereste = +_lereste;
		_nb_cities_array ="Error Array too big";
	};

	_temp_save = +_lereste;
	player sideChat "str(count _lereste)";
	player sideChat str(count _lereste);
	_temp_save resize _step;
	player sideChat "str(count _temp_save)";
	player sideChat str(count _temp_save);
	switch (["write", [_section, format ["%1_%2",_key,_nb_cities_array], _temp_save]] call OO_fnc_inidbi) do	{
		case true:
		{
			_lereste deleteRange [0,_step];
			if (count _lereste < _step) then {_step = count _lereste};
			_nb_cities_array = _nb_cities_array + 1;
		};
		case nil:
		{
			_step = floor(_step/2);
		};
		default
		{
			_step = floor(_step/2);
		};
	};
};
_nb_cities_array