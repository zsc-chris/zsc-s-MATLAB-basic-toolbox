function ret=movfunind(SamplePoints,k,Endpoints)
%MOVFUNIND	Generate indices for movfun series
%	ret=MOVFUNIND(SamplePoints,k,Endpoints) generates relative indices for
%	each point in the range specified by k according to SamplePoints. This
%	function is a utility for movfun series.
%	SamplePoints - [*SamplePoints]
%	k            - [kf,kb]
%	Endpoints    - "shrink"/"discard"/"fill"/(scalar fill value)
%
%	See also dnt

%	Copyright 2025 Chris H. Zhao
	arguments
		SamplePoints(1,:){mustBeNumeric}
		k(1,2)
		Endpoints(1,1)string{mustBeMember(Endpoints,["shrink","discard","fill"])}="shrink"
	end
	switch Endpoints
		case "shrink"
			ret=arrayfun(@(x,r1,r2)-r1+1:r2-1,1:numel(SamplePoints),movsum(ones(size(SamplePoints)),[k(1),0],SamplePoints=SamplePoints),movsum(ones(size(SamplePoints)),[0,k(2)],SamplePoints=SamplePoints),UniformOutput=false);
		case "discard"
			ret=arrayfun(@(x,r1,r2)-r1+1:r2-1,1:numel(SamplePoints),movsum(ones(size(SamplePoints)),[k(1),0],SamplePoints=SamplePoints),movsum(ones(size(SamplePoints)),[0,k(2)],SamplePoints=SamplePoints),UniformOutput=false);
			ret=ret(movprod(ones(size(SamplePoints)),[k(1),0],SamplePoints=SamplePoints,Endpoints=0)&movprod(ones(size(SamplePoints)),[0,k(2)],SamplePoints=SamplePoints,Endpoints=0));
		case "fill"
			ret=arrayfun(@(x,r1,r2)-r1+1:r2-1,1:numel(SamplePoints),movsum(ones(size(SamplePoints)),[k(1),0],SamplePoints=SamplePoints,Endpoints=1),movsum(ones(size(SamplePoints)),[0,k(2)],SamplePoints=SamplePoints,Endpoints=1),UniformOutput=false);
	end
end