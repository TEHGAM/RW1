if(!isServer)then
{
	_activatedAO = _this select 0;

	activatedAOIs set [0,_activatedAO];

	if(!(_activatedAO in activeAOList))then
	{
		publicVariableServer "activatedAOIs";
	};
};
