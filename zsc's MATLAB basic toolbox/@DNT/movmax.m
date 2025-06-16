function ret=movmax(self,k,dims,nanflag,options)
%MOVMAX	Moving maximum value for DNT data
%	ret=MOVMAX(self,k,dims=self.dimnames,nanflag="includemissing",*,
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
%	>> MOVMAX(DNT([1,2,3;4,5,6;7,8,nan],["a","b"]),{1,1},["a","b"],"omitmissing",SamplePoints={[1,1.5,2],1:3})
%
%	ans =
%
%	  3×3 DNT double matrix
%
%	         b         1    2    3
%	    a
%
%	    1              1    2    3
%	    2              4    5    6
%	    3              7    8    6
%
%	See also movmax, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		k(1,:){mustBeA(k,["numeric","cell"])}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="omitmissing"
		options.Endpoints(1,:){mustBeTrue("@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))",options.Endpoints,VariableNames="Endpoints")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}=arrayfun(@(x)1:x,size(self,dims),UniformOutput=false)
	end
	dstar=dstarclass;
	ret=movfun(@(x,dims,nanflag)max(x,[],dims,nanflag),self,k,dims,dstar{options},AdditionalInput={nanflag},FillValue=-inf);
end