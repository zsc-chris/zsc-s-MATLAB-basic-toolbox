function ret=movstd(self,k,w,dims,nanflag,options)
%MOVSTD	Moving standard deviation for DNT data
%	ret=MOVSTD(self,k,w=1,dims=self.dimnames,nanflag="includemissing",*,
%	Endpoints="shrink"[,SamplePoints])
%	self         - DNT
%	k            - {*k}/{*[kb,kf]}
%		If k is not a cell, k={k} will be called before processing.
%		If k is a scalar, it will be broadcast against dims.
%	w            - 0/1
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
%	>> MOVSTD(DNT([1,2,3;4,5,6;7,8,nan],["a","b"]),{1,1},1,["a","b"],"omitmissing",SamplePoints={[1,1.5,2],1:3})
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
%	See also movstd, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		k(1,:){mustBeA(k,["numeric","cell"])}
		w(1,1)double{mustBeMember(w,[0,1])}=1
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
		options.Endpoints(1,:){mustBeTrue("@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))",options.Endpoints,VariableNames="Endpoints")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}=arrayfun(@(x)1:x,size(self,dims),UniformOutput=false)
	end
	dstar=dstarclass;
	ret=movfun(@(x,dims,nanflag)zsc.std(x,w,dims,nanflag),self,k,dims,dstar{options},AdditionalInput={nanflag});
end