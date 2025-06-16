function DNTs=fevalalong(f,dims,DNTs,options)
%FEVALALONG	Eval a function on DNTs along certain dimensions
%	*DNTs=FEVALALONG(f,dims,*DNTs,Mode="direct",KeepDims=false,
%	Unflatten=false,KeepOtherDims=false,BroadcastSizeDims="other",
%	vectorized=true,AdditionalInput={}) allows one to specify dimension for
%	a function and provides different modes to process mutiple dimensions.
%	f                 - function_handle scalar
%		The signature for f should be: f(*DNTs,dims,*AdditionalInput) if
%		(Vectorized==true and Mode~="flattenall") else
%		f(*DNTs,*AdditionalInput)
%	dims              - [*dims]
%		Specified dimensions. dims can be string/char/cellstr/missing
%		(dimension names), numerical/logical (dimension indices for all
%		existing dimensions in input)
%		Missing dimensions will be treated as distict temporary dimensions
%		that is deleted after the operation. 
%	DNTs              - DNT
%	Mode              - string scalar
%		Mode can be "direct"(function operates on whole array)/"flatten"
%		(function operates on 1-D vector after flattening the dimensions)/
%		iterate(function operates on each dimension one by one)/
%		"flattenall"(function operates on 2-D table-like matrix after
%		flattening specified dimensions and other dimensions respectively)
%	KeepDims          - [*KeepDims]
%		KeepDims is an array one-by-one corresponding to each output, to
%		determine whether output will be squeezed along dims after
%		operation. If function is guaranteed to reduce dims for an output,
%		set corresponding element of KeepDims to false. Its last element
%		will be repeated in case of excessive outputs.
%	Unflatten         - [*Unflatten]
%		Unflatten is an array one-by-one corresponding to each output, to
%		determine whether output will be unflattened along dims after
%		operation (>0 or 0), and which input's size to recover to (positive
%		integer as subscript). UnflattenOther is only used if
%		contains(Mode,"flatten"), requiring corresponding element in
%		KeepDims to be true. Its last element will be repeated in case of
%		excessive outputs.
%	KeepOtherDims     - [*KeepOtherDims]
%		KeepOtherDims is an array one-by-one corresponding to each output,
%		to determine whether output will be squeezed along other dimensions
%		after operation. KeepOtherDims is only used if Mode=="flattenall"
%		mode. Its last element will be repeated in case of excessive
%		outputs.
%	UnflattenOther    - [*UnflattenOther]
%		UnflattenOther is an array one-by-one corresponding to each output,
%		to determine whether output will be unflattened along other
%		dimensions after operation (>0 or 0), and which input's size to
%		recover to (positive integer as subscript). UnflattenOther is only
%		used if Mode=="flattenall" mode, requiring corresponding element in
%		KeepOtherDims to be true. Its last element will be repeated in case
%		of excessive outputs.
%	BroadcastSizeDims - string scalar
%		BroadcastSizeDims can be "all"(broadcast inputs along all
%		dimensions)/ ""(broadcast inputs along dims)/"other"(broadcast
%		inputs along other dimensions) "none"(do not broadcast inputs)
%	Vectorized        - logical scalar
%		Specify if the function is vectorized. Vectorized must be true if
%		Mode=="flattenall". Otherwise one should set Mode to "flatten".
%	AdditionalInput   - {*AdditionalInput}
%
%	Set fun to @deal, KeepDims to true, BroadcastSizeDims to "", Vectorized
%	to false to manually broadcast DNTs along dims.
%
%	Note: Set KeepDims to true/false to mimic MATLAB/Python behavior
%		respectively.
%	Note: In flatten and flattenall mode, at least one dimension must be
%		specified. Otherwise a new dimension will be created if
%		KeepDims==true, as the function may turn scalar into vector.
%
%	Example:
%	>> FEVALALONG(@expm,["a","b"],DNT([1,2;3,4],["a","b","c"]),KeepDims=true,Vectorized=false)
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b                1           2
%	    a
%
%	    1               51.9690     74.7366
%	    2              112.1048    164.0738
%
%	See also DNT/applyalong, DNT/feval, DNT/fevalkernel

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}
	end
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Input)
		options.Mode(1,1)string{mustBeMember(options.Mode,["direct","flatten","iterate","flattenall"])}="direct"
		options.KeepDims(1,:)logical=false
		options.Unflatten(1,:)double{mustBeInteger,mustBeNonnegative}=0
		options.KeepOtherDims(1,:)logical=false
		options.UnflattenOther(1,:)double{mustBeInteger,mustBeNonnegative}=0
		options.BroadcastSizeDims(1,1)string{mustBeMember(options.BroadcastSizeDims,["all","","other","none"])}="other"
		options.Vectorized(1,1)logical=true
		options.AdditionalInput(:,1)cell={}
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	star=starclass;
	dimnames=unique([star{DNTs,2}{1}.dimnames]);
	dims=parsedims(dimnames,dims);
	maxstrlength=paddata(max(arrayfun(@strlength,rmmissing(union(dimnames,dims)))),1);
	missingfiller=string(arrayfun(@(x)string(repmat('_',1,maxstrlength+x)),1:nnz(ismissing(dims))));
	dims(ismissing(dims))=missingfiller;
	zsc.assert(isequal(sort(dims),unique(dims)),message("MATLAB:getdimarg:vecDimsMustBeUniquePositiveIntegers"))
	switch options.BroadcastSizeDims
		case "all"
			[DNTs{:},~]=feval(@deal,DNTs{:},DNT(0,dims),BroadcastSize=true);
		case {"","other"}
			if options.BroadcastSizeDims==""
				[tmp{1:numel(DNTs)}]=feval(@deal,star{cellfun(@(DNT)subsasgn(DNT,substruct(".","dimnames","()",{~ismember(DNT.dimnames,dims)}),missing),DNTs,UniformOutput=false),2}{:});
			else
				[tmp{1:numel(DNTs)}]=feval(@deal,star{cellfun(@(DNT)subsasgn(DNT,substruct(".","dimnames","()",{ismember(DNT.dimnames,dims)}),missing),DNTs,UniformOutput=false),2}{:});
			end
			tmp=tmp{1};
			out=outclass;
			DNTs=cellfun(@(DNT)out{2,1,@(varargin)feval(@deal,varargin{:}),DNT,tmp},DNTs,UniformOutput=false);
			clear tmp
			[DNTs{:},~]=feval(@deal,DNTs{:},DNT(0,dims),BroadcastSize=false);
		case "none"
			[DNTs{:},~]=feval(@deal,DNTs{:},DNT(0,dims),BroadcastSize=false);
	end
	dims=DNT.index(DNTs{1}.dimnames,dims);
	switch options.Mode
		case "direct"
			if options.Vectorized
				[tmp{1:nargout}]=f(star{DNTs,2}{:}.data,dims,options.AdditionalInput{:});
			else
				permutation=[dims,setdiff(1:ndims(DNTs{1}),dims)];
				tmp_=cellfun(@(x)zsc.permute(gather(x),permutation),DNTs,UniformOutput=false);
				tmp_=cellfun(@(x)num2cell(x,1:numel(dims)),tmp_,UniformOutput=false);
				[tmp{1:nargout}]=cellfun(@(varargin)f(varargin{:},options.AdditionalInput{:}),tmp_{:},UniformOutput=false);
				tmp=cellfun(@zsc.cell2mat,tmp,UniformOutput=false);
				tmp=cellfun(@(x)zsc.ipermute(x,permutation),tmp,UniformOutput=false);
			end
			DNTs=repmat(DNTs(1),[1,numel(tmp)]);
			for i=1:numel(tmp)
				DNTs{i}.data=tmp{i};
			end
		case "flatten"
			if isempty(dims)
				dims=ndims(DNTs{1})+1;
				DNTs=cellfun(@(x)subsasgn(x,substruct(".","dimnames"),[x.dimnames,DNT.gennewdims(dims)]),DNTs,UniformOutput=false);
			end
			sz=cell(1,numel(DNTs));
			for i=1:numel(DNTs)
				[DNTs{i},dim,sz{i}]=flatten(DNTs{i},dims);
			end
			if options.Vectorized
				[tmp{1:nargout}]=f(star{DNTs,2}{:}.data,DNT.index(DNTs{1}.dimnames,dim),options.AdditionalInput{:});
			else
				tmp_=cellfun(@(x)zsc.transpose(gather(x),[DNT.index(DNTs{1}.dimnames,dim),1]),DNTs,UniformOutput=false);
				tmp_=cellfun(@(x)num2cell(x,1),tmp_,UniformOutput=false);
				[tmp{1:nargout}]=cellfun(@(varargin)f(varargin{:},options.AdditionalInput{:}),tmp_{:},UniformOutput=false);
				tmp=cellfun(@(x)cellfun(@(y)paddata(y(:),[max(cellfun(@(x)numel(x),x),[],"all"),1],FillValue=tryinline(@()cast(missing,like=y),@(~)[])),x,UniformOutput=false),tmp,UniformOutput=false);
				tmp=cellfun(@zsc.cell2mat,tmp,UniformOutput=false);
				tmp=cellfun(@(x)zsc.transpose(x,[DNT.index(DNTs{1}.dimnames,dim),1]),tmp,UniformOutput=false);
			end
			DNTs=repmat(DNTs(1),[1,numel(tmp)]);
			for i=1:numel(tmp)
				DNTs{i}.data=tmp{i};
			end
		case "iterate"
			for dim=dims
				if options.Vectorized
					[tmp{1:numel(DNTs)}]=f(star{DNTs}{:}.data,dim,options.AdditionalInput{:});
				else
					tmp_=cellfun(@(x)zsc.transpose(gather(x),[dim,1]),DNTs,UniformOutput=false);
					tmp_=cellfun(@(x)num2cell(x,1),tmp_,UniformOutput=false);
					[tmp{1:numel(DNTs)}]=cellfun(@(varargin)f(varargin{:},options.AdditionalInput{:}),tmp_{:},UniformOutput=false);
					tmp=cellfun(@(x)cellfun(@(y)paddata(y(:),[max(cellfun(@(x)numel(x),x),[],"all"),1],FillValue=tryinline(@()cast(missing,like=y),@(~)[])),x,UniformOutput=false),tmp,UniformOutput=false);
					tmp=cellfun(@zsc.cell2mat,tmp,UniformOutput=false);
					tmp=cellfun(@(x)zsc.transpose(x,[dim,1]),tmp,UniformOutput=false);
				end
				for i=1:numel(DNTs)
					DNTs{i}.data=tmp{i};
				end
			end
		case "flattenall" % for situation where "rows" are treated as a whole and function operates on "columns", like unique.
			if isempty(dims)
				dims=ndims(DNTs{1})+1;
				DNTs=cellfun(@(x)subsasgn(x,substruct(".","dimnames"),[x.dimnames,DNT.gennewdims(dims)]),DNTs,UniformOutput=false);
			end
			[sz,szother]=deal(cell(1,numel(DNTs)));
			for i=1:numel(DNTs)
				[DNTs{i},otherdim,szother{i}]=flatten(DNTs{i},setdiff(1:ndims(DNTs{i}),dims));
				[DNTs{i},dim,sz{i}]=flatten(DNTs{i},dims);
			end
			tmp_=cellfun(@(x)permute(x,[dim,otherdim]),DNTs,UniformOutput=false);
			zsc.assert(options.Vectorized,"ZSC:DNT:fevalalong:vectorizedWithFlattenall","There is no point to set vectorized=false when mode=flattenall. Use mode=flatten instead.")
			[tmp{1:nargout}]=f(tmp_{:},options.AdditionalInput{:});
			constructor=str2func(class(DNTs{1}));
			DNTs=cellfun(@(x)constructor(x,[dim,otherdim]),tmp,UniformOutput=false);
			options.KeepOtherDims=resize(options.KeepOtherDims,numel(DNTs),FillValue=ifinline(isempty(options.KeepOtherDims),@()false,@()options.KeepOtherDims(end)));
			options.UnflattenOther=resize(options.UnflattenOther,numel(DNTs),FillValue=ifinline(isempty(options.UnflattenOther),@()0,@()options.UnflattenOther(end)));
			zsc.assert(all(~options.UnflattenOther|options.KeepOtherDims),"ZSC:DNT:fevalalong:unflattenWithKeepdims","UnflattenOther>0 must be based on KeepOtherDims.")
			DNTs=arrayfun(@(x,y)ifinline(y,@()unflatten(x{1},otherdim,szother{y}),@()x{1}),DNTs,options.UnflattenOther,UniformOutput=false);
			DNTs=arrayfun(@(x,y)ifinline(y,@()x{1},@()squeeze(x{1},otherdim)),DNTs,options.KeepOtherDims,UniformOutput=false);
	end
	options.KeepDims=resize(options.KeepDims,numel(DNTs),FillValue=ifinline(isempty(options.KeepDims),@()false,@()options.KeepDims(end)));
	if contains(options.Mode,"flatten")
		options.Unflatten=resize(options.Unflatten,numel(DNTs),FillValue=ifinline(isempty(options.Unflatten),@()0,@()options.Unflatten(end)));
		zsc.assert(all(~options.Unflatten|options.KeepDims),"ZSC:DNT:fevalalong:unflattenWithKeepdims","Unflatten>0 must be based on KeepDims.")
		DNTs=arrayfun(@(x,y)ifinline(y,@()unflatten(x{1},dim,sz{y}),@()x{1}),DNTs,options.Unflatten,UniformOutput=false);
		DNTs=arrayfun(@(x,y)ifinline(y,@()x{1},@()squeeze(x{1},dim)),DNTs,options.KeepDims,UniformOutput=false);
	else
		DNTs=arrayfun(@(x,y)ifinline(y,@()x{1},@()squeeze(x{1},dims)),DNTs,options.KeepDims,UniformOutput=false);
	end
	for i=1:numel(DNTs)
		DNTs{i}.dimnames(ismember(DNTs{i}.dimnames,missingfiller))=missing;
	end
end