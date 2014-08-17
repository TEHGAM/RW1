if(isServer)then
{
	_AO = _this select 0;
	_allGroups = allGroups;
	_indepGroups = [];

	{
		if(side _x == resistance)then
		{
			_groupLeader = leader _x;
			if((_groupLeader distance _AO) <= 800)then
			{
				_groupUnits = units _x;
				_tempArray = _indepGroups;
				_indepGroups = _tempArray + _groupUnits;
			};
		};
	}forEach _allGroups;

	{
		deleteVehicle _x;
	}forEach _indepGroups;
};