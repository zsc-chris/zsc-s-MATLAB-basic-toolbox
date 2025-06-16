function ret=minndims(x)
%MINNDIMS	Minimal dimension number for a tensor
%	ret=MINNDIMS(x) returns the minimal number of : so that x(:,:,...,:) is
%	equal to x.

%	Copyright 2025 Chris H. Zhao
	ret=find(size(x)~=1,1,"last");
	if isempty(ret)
		ret=0;
	end
end