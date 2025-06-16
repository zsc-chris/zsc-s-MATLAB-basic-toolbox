function ret=movfun(fun,self,k,dims,options)
%MOVFUN	Moving function for DNT data
%	ret=MOVFUN(fun,self,k,dims=self.dimnames,nanflag="includemissing",*,
%	Endpoints="shrink",SamplePoints=arrayfun(@(x)1:x,size(self,dims),
%	UniformOutput=false),AdditionalInput={})
%	fun             - function_handle
%	self            - DNT
%	k               - {*k}/{*[kb,kf]}
%		If k is not a cell, k={k} will be called before processing.
%		If k is a scalar, it will be broadcast against dims.
%	dims            - [*dims]/[*dimnames]
%	Endpoints       - "shrink"/"discard"/"fill"/(scalar fill value)
%	SamplePoints    - {*SamplePoints}
%		If SamplePoints is not a cell, SamplePoints={SamplePoints} will be
%		called before processing.
%		If SamplePoints is a scalar, it will be broadcast against dims.
%	AdditionalInput - {*AdditionalInput}
%
%	Note: k and SamplePoints should either be broadcast to dims or be
%	one-to-one correspondent to dims.
%
%	Example:
%	>> MOVFUN(@mode,DNT([1,2,3;4,5,6;7,8,nan],["a","b"]),{1,1},["a","b"],SamplePoints={[1,1.5,2],1:3})
%
%	ans =
%
%	  3×3 DNT double matrix
%
%	         b         1    2    3
%	    a
%
%	    1              1    2    3
%	    2              1    2    3
%	    3              4    5    6
%
%	See also movmad, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		fun(1,1)function_handle
		self DNT
		k(1,:){mustBeA(k,["numeric","cell"])}
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		options.Endpoints(1,:){mustBeTrue("@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))",options.Endpoints,VariableNames="Endpoints")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}=arrayfun(@(x)1:x,size(self,dims),UniformOutput=false)
		options.FillValue(1,1)=missing
		options.AdditionalInput(1,:)cell={}
	end
	dstar=dstarclass;
	dims=parsedims(self.dimnames,dims);
	if ~iscell(k)
		k={k};
	end
	if ~iscell(options.SamplePoints)
		options.SamplePoints={options.SamplePoints};
	end
	k=flatten(zsc.cat(1,num2cell(dims),k));
	options.SamplePoints=flatten(zsc.cat(1,num2cell(dims),options.SamplePoints));
	ret=fevalkernel(fun,k,self,dstar{options},Mode="dist");
end