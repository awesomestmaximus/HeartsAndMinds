
_buildings = nearestObjects [(_this select 0), ["Building"], (_this select 1)];
_useful    = [];
{
	if (format["%1", _x buildingPos 2] != "[0,0,0]" && {damage _x isEqualTo 0} && {isNil {_x getVariable "btc_house_taken"}}) then	{
		_useful pushBack _x;
	};
} forEach _buildings;
_useful