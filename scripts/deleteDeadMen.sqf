while{true}do
{
	{
		if(!isPlayer _x)then{deleteVehicle _x;};
	 	deleteVehicle _x;

	} forEach allDeadMen;

	sleep 1000;
};

