if(isServer)then
{
    _spawnLocation = _this select 0;
    _sideOfSquad = _this Select 1;
    _typeOfSquad = _this select 2;
    _numberOfSquads = _this Select 3;

    _squad = [];
    _squadTypes = [];
    _squadTypesFromConfig = "";
    _side = "";
    _faction = "";
    _grpSide = "";
    _squadType = "";

    switch (_sideOfSquad) do
    {
        case "Indep":
        {
            _side = "Indep";_faction = "IND_F";_grpSide = resistance;
        };

        case "Opfor":
        {
            _side = "East";_faction = "OPF_F";_grpSide = east;
        };
        case "Blufor":
        {
            _side="West";_faction="BLU_F";_grpSide = west;
        };
    };

    switch(_typeOfSquad)do
    {
        case "Infantry":
        {
            _squadType = _typeOfSquad;
        };
        case "Sniper":
        {
            _squadType = "Infantry";
            _numberOfSquads = 4;
        };
        case "Mechanized":
        {
            _squadType = _typeOfSquad;
            _numberOfSquads = 4;
        };
    };

    _squadTypesFromConfig = configFile >>"CfgGroups">>_side>>_faction>>_squadType;

    for [{_i=0},{_i<count (_squadTypesFromConfig)},{_i=_i+1}] do
    {
        _type = _squadTypesFromConfig select _i;
        if(isClass _type)then
        {
            _className = configName (_type);
            _squadTypes set [(count _squadTypes),_className];
        }
    };

    _countNumberOfSquads = 0;
    _patrolCount = 0;

    if(_typeOfSquad == "Mechanized")then{ _numberOfSquads = floor(random _numberOfSquads)};

    while {_countNumberOfSquads < _numberOfSquads} do
    {

        _random = _squadTypes select floor (random (count _squadTypes));

        switch (_typeOfSquad) do
        {
            case "Infantry":
            {
                switch (_sideOfSquad) do
                {
                    case "Indep":
                    {
                        while {_random == "HAF_InfSentry" || _random == "HAF_SniperTeam"} do
                        {
                           _random = _squadTypes select floor (random (count _squadTypes));
                        };
                    };

                    case "Opfor":
                    {
                        while {_random == "OIA_InfSentry" || _random == "OI_reconSentry" || _random == "OI_SniperTeam"} do
                        {
                           _random = _squadTypes select floor (random (count _squadTypes));
                        };
                    };
                    case "Blufor":
                    {
                        while {_random == "BUS_InfSentry" || _random == "BUS_reconSentry" || _random == "BUS_SniperTeam"} do
                        {
                           _random = _squadTypes select floor (random (count _squadTypes));
                        };
                    };
                };
            };

            case "Sniper":
            {
                switch (_sideOfSquad) do
                {
                    case "Indep":
                    {
                        _random = "HAF_SniperTeam";
                    };

                    case "Opfor":
                    {
                        _random = "OI_SniperTeam";
                    };
                    case "Blufor":
                    {
                        _random = "BUS_SniperTeam";
                    };
                };
            };
        };

        _radius = 400;
        if(_countNumberOfSquads < 2 && _typeOfSquad != "Mechanized")then{_radius = 100;};

        _nearestObjectPosition = nearestObject (position _spawnLocation);
        _roadsInRange = _nearestObjectPosition nearRoads _radius;
        _randomRoadInRange = _roadsInRange select floor (random (count _roadsInRange));

        _checkSize = count (configFile >>"CfgGroups">>_side>>_faction>>_squadType>>_random);
        _numberOfUnits = floor random _checkSize;
        _chanceOfSpawn = 0.2;

        if((str(_spawnLocation)) == "Kavala")then{_chanceOfSpawn = 1;};

        if(_checkSize < 4)then{_checkSize = 4;};

        _squad = units ([position _randomRoadInRange, _grpSide, (configFile >>"CfgGroups">>_side>>_faction>>_squadType>>_random),[],[],[],[],[_checkSize,_chanceOfSpawn],180] call BIS_fnc_spawnGroup);

        {
            _x setSkill ["aimingAccuracy",([(paramsarray select 3)] call Hercx_AIDifficulty)];
            _x setSkill ["aimingShake", 0.9];
            _x setSkill ["aimingSpeed", 0.6];
            _x setSkill ["endurance", 0.7];
            _x setSkill ["spotDistance", 0.45];
            _x setSkill ["spotTime", 0.7];
            _x setSkill ["courage", 0.8];
            _x setSkill ["reloadSpeed", 1];
            _x setSkill ["commanding", 1];
            _x setSkill ["general", 0.7];
        }forEach _squad;

        _grpLeader = leader (_squad select 0);

        if(_numberOfSquads > 8 && _patrolCount > 8)then
        {
            if(_countNumberOfSquads % 2 == 0)then
            {
                [(position _randomRoadInRange),(group _grpLeader),_radius] call Hercx_AOWaypointsCreate;
            };
        }
        else
        {
            [(position _randomRoadInRange),(group _grpLeader),_radius] call Hercx_AOWaypointsCreate;
        };
        _countNumberOfSquads = _countNumberOfSquads + 1;
        _patrolCount = _patrolCount + 1;
    };
};
