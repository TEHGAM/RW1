for [ { _i = 0 }, { _i < count(missionConfigFile >> "Params") }, { _i = _i + 1 } ] do {
	_paramName = (configName ((missionConfigFile >> "Params") select _i));
	_paramValue = 0;
	if (!isNil "paramsArray") then {	
		_paramValue = (paramsArray select _i);
	}else{
		_paramValue = (getNumber (missionConfigFile >> "Params" >> _paramName >> "default"));	
	};
	_paramCode = ( getText (missionConfigFile >> "Params" >> _paramName >> "code"));
	_code = format[_paramCode, _paramValue];
	call compile _code;
};