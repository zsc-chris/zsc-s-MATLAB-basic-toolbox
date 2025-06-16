function DNTs=fevalkernel(kernel,kernelind,DNTs,options,indexingoptions,movfunoptions,fevalalongoptions)
%FEVALKERNEL	Eval a kernel function on DNTs
%	*DNTs=FEVALKERNEL(kernel,kernelind,*DNTs,Mode=="sub",FillValue=missing,
%	Pattern="constant",Endpoints="shrink",SamplePoints="
%	kernelind is index if Mode=="sub", and size if Mode=="dist"
%	kernel          - function_handle scalar
%		kernel will operate on each kernel using fevalalong, in which
%		Mode=="direct" and KeepDims==false.
%		The signature for kernel should be: kernel(*DNTs,dims,
%		*AdditionalInput) if Vectorized=true else kernel(*DNTs,
%		*AdditionalInput).
%	kernelind       - {*kernelind}/{**kernelind}
%		kernelind specify relative subscripts/total or [front,back]
%		distance for Mode="sub"/"dist" respectively.
%		If kernelind is not cell, kernelind={kernelind} will be called
%		before processing.
%	DNTs            - DNT
%	Mode            - string scalar
%		Mode can be "sub"(define kernel region by relative subscript)/
%		"dist" (define kernel region by distance)
%	FillValue       - scalar
%		Specify FillValue in zsc.indexing for padded data due to
%		out-of-bound in both modes (only effective if Endpoints="fill" when
%		Mode=="dist")
%	Pattern         - string scalar
%		Specify Pattern in zsc.indexing for padded data due to out-of-bound
%		in both modes (only effective if Endpoints="fill" when
%		Mode=="dist")
%	Endpoints       - scalar
%		Specify Endpoints in movfun for method of padding data when
%		Mode=="dist".
%	SamplePoints    - {*SamplePoints}/{**SamplePoints} 
%		If SamplePoints is not cell, SamplePoints={SamplePoints} will be
%		called before processing.
%	Vectorized      - logical scalar
%		Specify Vectorized in fevalalong.
%	AdditionalInput - {*AdditionalInput}
%		Specify AdditionalInput in fevalalong.
%
%	Note: Only supports square grid. If one wants other shapes, use
%		logical/strel mask in f.
%
%	Example:
%	>> FEVALKERNEL(@(a,dims)max(a,[],dims),{"a",-1:1,"b",-1:1},DNT([1,2;3,4],["a","b"]),Mode="sub")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              4    4
%	    2              4    4
%
%	>> FEVALKERNEL(@(a,dims)max(a,[],dims),{"a",[1,1],"b",[1,1]},DNT([1,2;3,4],["a","b"]),Mode="dist")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              4    4
%	    2              4    4
%
%	See also DNT/applykernel, DNT/feval, DNT/fevalalong

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		kernel(1,1)function_handle
		kernelind{mustBeTrue("@(kernelind)isa(kernelind,""cell"")||isscalar(kernelind)&&isa(kernelind,""strel"")||isnumeric(kernelind)||islogical(kernelind)",kernelind,VariableNames="kernelind")}
	end
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Input)
		options.Mode(1,1)string{mustBeMember(options.Mode,["sub","dist"])}="sub"
		indexingoptions.FillValue(1,1)=missing
		indexingoptions.Pattern(1,1)string{mustBeMember(indexingoptions.Pattern,["constant","edge","circular","flip","reflect"])}="constant"
		movfunoptions.Endpoints(1,:){mustBeTrue("@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))",movfunoptions.Endpoints,VariableNames="Endpoints")}="shrink"
		movfunoptions.SamplePoints(1,:){mustBeA(movfunoptions.SamplePoints,["numeric","cell"])}
		fevalalongoptions.Vectorized(1,1)=true
		fevalalongoptions.AdditionalInput(1,:)cell={}
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	star=starclass;
	dstar=dstarclass;
	constructor=str2func(class(DNTs{1}));
	switch options.Mode
		case "sub"
			if ~iscell(kernelind)
				kernelind={kernelind};
			end
			kernelind=parsedimargs(unique([star{DNTs,2}{1}.dimnames]),kernelind,false);
			dims=paddata(string(zsc.cell2mat(kernelind(1,:))),[1,0]);
			kernelind=kernelind(2,:);
			kernelind=arrayfun(@(x,y)constructor(x{:},y),kernelind,dims,UniformOutput=false);
			[DNTs{:},~]=feval(@deal,DNTs{:},constructor(0,dims));
			dims_=DNTs{1}.dimnames;
			otherdims=setdiff(dims_,dims);
			kernelind=lookup(dictionary(dims_,kernelind),dims_,fallbackvalue={ones(size(kernelind{1}))});
			[ind1{1:ndims(DNTs{1})}]=zsc.ind2sub(size(DNTs{1}),zsc.reshape(1:numel(DNTs{1}),size(DNTs{1})));
			ind1=cellfun(@(x)constructor(x,dims),ind1,UniformOutput=false);
			[ind2{1:ndims(DNTs{1})}]=ndgrid(kernelind{:});
			ind2=cellfun(@(x)constructor(x,dims_+"'"),ind2,UniformOutput=false);
			ind=cellfun(@plus,ind1,ind2,UniformOutput=false);
			dims__=ind{1}.dimnames;
			ind=cellfun(@gather,ind,UniformOutput=false);
			DNTs=cellfun(@(x)constructor(zsc.indexing(gather(x),ind,dstar{indexingoptions}),dims__),DNTs,UniformOutput=false);
			DNTs=cellfun(@(x)squeeze(x,otherdims+"'"),DNTs,UniformOutput=false);
			[tmp{1:nargout}]=fevalalong(kernel,dims_+"'",DNTs{:},dstar{fevalalongoptions});
		case "dist"
			if ~iscell(kernelind)
				kernelind={kernelind};
			end
			if ~isnumeric(movfunoptions.Endpoints)
				movfunoptions.Endpoints=string(movfunoptions.Endpoints);
			end
			kernelind=parsedimargs(unique([star{DNTs,2}{1}.dimnames]),kernelind,false);
			kernelind(2,:)=cellfun(@(x)ifinline(isscalar(x),@()[x/2,prevreal(x/2)],@()x),kernelind(2,:),UniformOutput=false);
			dims=paddata(string(zsc.cell2mat(kernelind(1,:))),[1,0]);
			kernelind=kernelind(2,:);
			[DNTs{:},~]=feval(@deal,DNTs{:},constructor(0,dims));
			dims_=DNTs{1}.dimnames;
			if ~isfield(movfunoptions,"SamplePoints")
				movfunoptions.SamplePoints=arrayfun(@(x)1:x,size(DNTs{1},dims),UniformOutput=false);
			else
				if ~iscell(movfunoptions.SamplePoints)
					movfunoptions.SamplePoints={movfunoptions.SamplePoints};
				end
				movfunoptions.SamplePoints=parsedimargs(dims_,movfunoptions.SamplePoints,false);
				zsc.assert(isequaln(zsc.cell2mat(movfunoptions.SamplePoints(1,:)),dims),"ZSC:DNT:fevalkernel:dimensionNotMatched","The dimension of SamplePoints must match with that of kernelind.")
				movfunoptions.SamplePoints=movfunoptions.SamplePoints(2,:);
				zsc.assert(succeeds(@()assert(all(cellfun(@isuniform,movfunoptions.SamplePoints))))||succeeds(@()assert(string(movfunoptions.Endpoints)=="shrink")),message("MATLAB:movfun:endpointChoiceInvalid"))
			end
			otherdims=setdiff(dims_,dims);
			kernelind=lookup(dictionary(dims,kernelind),dims_,fallbackvalue={[0 0]});
			movfunoptions.SamplePoints=arrayfun(@(dim)lookup(dictionary(dims,movfunoptions.SamplePoints),dim,fallbackvalue={1:end_(DNTs{1},dim)}),dims_);
			[ind1{1:ndims(DNTs{1})}]=zsc.ind2sub(size(DNTs{1}),zsc.reshape(1:numel(DNTs{1}),size(DNTs{1})));
			if isnumeric(movfunoptions.Endpoints)||movfunoptions.Endpoints=="fill"
				ind2=cellfun(@(x,r)movfunind(x,r,"fill"),movfunoptions.SamplePoints,kernelind,UniformOutput=false);
			else
				ind2=cellfun(@(x,r)movfunind(x,r,movfunoptions.Endpoints),movfunoptions.SamplePoints,kernelind,UniformOutput=false);
			end
			[ind2{:}]=ndgrid(ind2{:});
			[ind2{:}]=cellfun(@ndgrid,ind2{:},UniformOutput=false);
			ind=cellfun(@(x,y)arrayfun(@(x,y)x+y{:},x,y,UniformOutput=false),ind1,ind2,UniformOutput=false);
			ind=cellfun(@(x)gather(x),ind,UniformOutput=false);
			if isnumeric(movfunoptions.Endpoints)
				DNTs=cellfun(@(x)cellfun(@(varargin)constructor(zsc.indexing(gather(x),varargin,FillValue=movfunoptions.Endpoints),dims_),ind{:},UniformOutput=false),DNTs,UniformOutput=false);
			else
				DNTs=cellfun(@(x)cellfun(@(varargin)constructor(zsc.indexing(gather(x),varargin,dstar{indexingoptions}),dims_),ind{:},UniformOutput=false),DNTs,UniformOutput=false);
			end
			DNTs=cellfun(@(x)cellfun(@(x)squeeze(x,otherdims),x,UniformOutput=false),DNTs,UniformOutput=false);
			[tmp{1:nargout}]=cellfun(@(varargin)fevalalong(kernel,dims,varargin{:},dstar{fevalalongoptions}),DNTs{:},UniformOutput=false);
			tmp=cellfun(@(x)cell2mat(constructor(x,dims_)),tmp,UniformOutput=false);
	end
	DNTs=tmp;
end