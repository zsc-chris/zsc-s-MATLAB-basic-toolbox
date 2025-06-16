function ret=movmad(self,k,dims,nanflag,options)
%MOVMAD	Moving median absolute deviation value for DNT data
%	ret=MOVMAD(self,k,dims=self.dimnames,nanflag="includemissing",*,
%	Endpoints="shrink"[,SamplePoints])
%	self         - DNT
%	k            - {*k}/{*[kb,kf]}
%		If k is not a cell, k={k} will be called before processing.
%		If k is a scalar, it will be broadcast against dims.
%	dims         - [*dims]/[*dimnames]
%	nanflag      - "includemissing"/"includenan"/"omitmissing"/"omitnan"
%	Endpoints    - "shrink"/"discard"/"fill"/(scalar fill value)
%	SamplePoints    - {*SamplePoints}
%		If SamplePoints is not a cell, SamplePoints={SamplePoints} will be
%		called before processing.
%		If SamplePoints is a scalar, it will be broadcast against dims.
%
%	Note: k and SamplePoints should either be broadcast to dims or be
%	one-to-one correspondent to dims.
%
%	Example:
%	>> MOVMAD(DNT([1,2,3;4,5,6;7,8,nan],["a","b"]),{1,1},["a","b"],"omitmissing",SamplePoints={[1,1.5,2],1:3})
%
%	ans =
%
%	  3×3 DNT double matrix
%
%	         b              1         2         3
%	    a
%
%	    1                   0         0         0
%	    2              1.5000    1.5000    1.5000
%	    3              1.5000    1.5000         0
%
%	See also movmad, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		k(1,:){mustBeA(k,["numeric","cell"])}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
		options.Endpoints(1,:){mustBeTrue("@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))",options.Endpoints,VariableNames="Endpoints")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}=arrayfun(@(x)1:x,size(self,dims),UniformOutput=false)
	end
	dstar=dstarclass;
	ret=movfun(@(x,dims,nanflag)median(abs(x-median(x,dims,nanflag)),dims,nanflag),self,k,dims,dstar{options},AdditionalInput={nanflag});
end