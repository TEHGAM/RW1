// Как активировать действия?
_caller = _this select 1;

// Move them 5m behind the MHQ.
_worldPos = MHQ_West modelToWorld [0,-5,0];
_caller setPos [_worldPos select 0, _worldPos select 1, 0];