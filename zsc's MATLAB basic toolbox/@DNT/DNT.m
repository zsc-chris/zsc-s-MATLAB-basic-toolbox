classdef(InferiorClasses={?zsc.function_handle})DNT<dotprivate&matlab.mixin.CustomCompactDisplayProvider&parallel.internal.array.PlottableUsingGather
%DNT	Dimension-named tensor
%	ret=DNT(data=0,dimnames=DNT.gennewdims(1:minndims(data)) if
%	isa(data,"DNT") else data.dimnames) returns a DNT object. If dimnames
%	is specified, data will be flattened for #numel(dimnames) to
%	#numel(data) dimension.
%
%	The dimension number serve as alias for dimension number (for easier
%	management) and automatically broadcasts, so there is no need to
%	remember the ordering of dimensions. 
%
%	missing is considered a temporary dimension that will be removed after
%	any operation. Thus, one may use ....dimnames(...)=missing or
%	squeeze(...) to remove a dimension.
%
%	Special methods: end, where function call serves for matlab
%	compatibility and dot-method call serves for user use: end(...,...)
%	behaves differently from ....end(...).
%
%	Note: This class combines Fortran-style order, MATLAB array linear
%		indexing and python numpy.ndarray broadcast indexing.
%
%	Example:
%	>> integral(@(x)gather(sum(DNT(x,"x").^DNT(1:5,"n"),"n"))',0,1)
%
%	ans =
%
%	    1.4500
%
%	>> integral(@(x)integral(@(y)gather(DNT(x,"x").*DNT(y,"y")),1,5,ArrayValued=true)',1,5)
%
%	ans =
%
%		144
%
%	>> integral(@(x)integral(@(y)gather(DNT(x,"x").*DNT(y,"y")),1,5,ArrayValued=true),1,5,ArrayValued=true)
%
%	ans =
%
%		144
%
%	See also DNT/subsref, DNT/feval, DNT/fevalalong, DNT/fevalkernel,
%	DNT/accumarray, DNT/permute, einsum

%	Copyright 2024–2025 Chris H. Zhao
	properties
		%DATA	Tensor data
		%	DATA is automatically permuted according to dimnames.
		%	Setting DATA will extend dimnames to length minndims(DATA).
		data=0
	end
	properties(AbortSet)
		%DIMNAMES	Names of dimensions
		%	DIMNAMES automatically sorts and permutes data accordingly.
		%	Setting DIMNAMES will flatten data to length(DIMNAMES).
		dimnames(1,:)string=string.empty(1,0)
	end
	methods
		function ret=DNT(data,dimnames)
		%DNT	Constructor for DNT
		%	ret=DNT(data=0,dimnames=data.dimnames if isa(data,"DNT")
		%	else DNT.gennewdims(1:minndims(data))) flattens data to align
		%	with dimnames.
			arguments(Input)
				data=0
				dimnames(1,:)string=ifinline(isa(data,"DNT"),@()data.dimnames,@()DNT.gennewdims(1:minndims(data)))
			end
			arguments(Output)
				ret DNT
			end
			if isa(data,"DNT")
				ret=data;
			else
				ret.data=data;
			end
			ret.dimnames=dimnames;
		end
		function self=set.data(self,data)
			arguments(Input)
				self DNT
				data=[]
			end
			arguments(Output)
				self DNT
			end
			dimnames=self.dimnames;
			if minndims(data)>numel(dimnames)
				dimnames=[dimnames DNT.gennewdims(numel(dimnames)+1:minndims(data))];
				[dimnames,permutation]=sort(dimnames);
				data=zsc.permute(data,permutation);
			end
			self.data=data;
			self.dimnames=dimnames;
		end
		function self=set.dimnames(self,dimnames)
			arguments(Input)
				self DNT
				dimnames(1,:)string=DNT.gennewdims(1:minndims(self.data))
			end
			arguments(Output)
				self DNT
			end
			data=self.data;
			ndimsnew=numel(dimnames);
			if ndimsnew<minndims(data)
				if ndimsnew==0
					data=ifinline(isempty(data),@()createArray(1,Like=data),@()data(1));
				else
					data=subsref(data,substruct("()",repmat({':'},[1,ndimsnew])));
				end
			end
			for i=unique(dimnames)
				data=getdiag(data,find(dimnames==i));
				dimnames=[i,dimnames(dimnames~=i)];
			end
			[dimnames,permutation]=sort(dimnames);
			data=zsc.permute(data,permutation);
			if anymissing(dimnames)
				if isempty(data)
					data=createArray(ternary(ismissing(dimnames),1,size(data,1:numel(dimnames))),Like=data);
				else
					data=subsref(data,substruct("()",ternary(ismissing(dimnames),repmat({1},[1,numel(dimnames)]),repmat({':'},[1,numel(dimnames)]))));
				end
				dimnames=dimnames(~ismissing(dimnames));
			end
			self.dimnames=dimnames;
			self.data=data;
		end
		varargout=size(self,dims)
		% sz=size(self,dims)
		ret=end(self,k,n)
		ret=colon(j,i,k)
		ret=linspace(self,other,n,dim,options)
		ret=logspace(self,other,n,dim,options)
		[ret,step]=isuniform(self,dims)
		% B=subsref(self,S)
		varargout=subsref(self,S)
		self=subsasgn(self,S,B)
		ret=subsindex(self)
		ret=numArgumentsFromSubscript(self,s,indexingContext)
		ret=squeeze(self,dims)
		function ret=zsc.squeeze(self,dims)
		%zsc.squeeze	Remove singleton dimensions
		%	ret=zsc.squeeze(self,dims=find(size(self)==1))
		%	DNT/zsc.squeeze is an alias for DNT/squeeze.
		%
		%	See also DNT/squeeze, zsc.squeeze, squeeze, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT
				dims(1,:)=find(size(self)==1)
			end
			arguments(Output)
				ret DNT
			end
			ret=squeeze(self,dims);
		end
		ret=ndims(self)
		ret=numel(self)
		ret=length(self)
		disp(self)
		display(self,objName)
		function ret=matlab.internal.display.dimensionString(self,addempty)
		%matlab.internal.display.dimensionString	Obtain the dimension
		%string of the given input
		%	ret=matlab.internal.display.dimensionString(self,
		%	addempty=false)
		%
		%	See also matlab.internal.display.dimensionString, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT
				addempty(1,1)logical=false
			end
			arguments(Output)
				ret(1,1)string
			end
			switch ndims(self)
				case 0
					ret="scalar";
				case 1
					ret=numel(self);
				case 2
					ret=join(string(size(self)),"×");
				otherwise
					if ndims(self)<=double(string(fileread("maxdispndims.txt")))
						ret=join(string(size(self)),"×");
					else
						ret=ndims(self)+"-D";
					end
			end
			if isempty(self)&&addempty
				ret=ret+" empty";
			end
		end
		ret=compactRepresentationForColumn(self,~,~)
		ret=broadcast(self,sz)
		ret=isempty(self)
		ret=isscalar(self)
		ret=isvector(self)
		ret=isrow(self)
		ret=iscolumn(self)
		ret=ismatrix(self)
		ret=isUnderlyingType(self,classname)
		ret=underlyingType(self)
		validateattributes(self,varargin)
		ret=isfloat(self)
		ret=isinteger(self)
		ret=ischar(self)
		ret=islogical(self)
		ret=isstring(self)
		ret=iscell(self)
		ret=isstruct(self)
		ret=isnumeric(self)
		ret=isreal(self)
		ret=isenum(self)
		ret=ismissing(self,indicator)
		ret=isinf(self)
		ret=isnan(self)
		ret=isfinite(self)
		ret=isvalid(self)
		ret=isapprox(self,other,tol)
		ret=isequal(DNTs)
		ret=isequaln(DNTs)
		ret=keyHash(self)
		ret=keyMatch(self)
		ret=superiorfloat(varargin)
		varargout=gather(varargin)
		ret=cast(self,newclass,options)
		ret=typecast(self,newclass,options)
		ret=double(self)
		ret=single(self)
		ret=logical(self)
		ret=string(self)
		ret=char(self)
		ret=int8(self)
		ret=uint8(self)
		ret=int16(self)
		ret=uint16(self)
		ret=int32(self)
		ret=uint32(self)
		ret=int64(self)
		ret=uint64(self)
		ret=num2cell(self,dims)
		ret=mat2cell(self,dimDist)
		ret=cell2mat(self,dims,finalize)
		function ret=zsc.cell2mat(self,dims,finalize)
		%zsc.cell2mat	Convert the contents of a cell array into a single
		%tensor
		%	ret=zsc.cell2mat(self,dims=self.dimnames,finalize=true)
		%	DNT/zsc.cell2mat is an alias for DNT/cell2mat.
		%
		%	See also DNT/cell2mat, zsc.cell2mat, cell2mat, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT{mustBeUnderlyingType(self,"cell")}
				dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
				finalize(1,1)logical=true
			end
			arguments(Output)
				ret
			end
			ret=cell2mat(self,dims,finalize);
		end
		ret=sparse(self)
		ret=issparse(self)
		ret=full(self)
		ret=tall(self)
		ret=codistributed(self)
		ret=distributed(self)
		ret=gpuArray(self)
		ret=sym(self)
		ret=eps(self,p)
		ret=uplus(self)
		ret=uminus(self)
		ret=sign(self)
		ret=abs(self)
		ret=angle(self)
		ret=real(self)
		ret=imag(self)
		ret=conj(self)
		ret=ceil(self)
		ret=fix(self)
		ret=floor(self)
		ret=round(self)
		ret=sqrt(self)
		ret=pow2(self,E)
		ret=exp(self)
		[ret,E]=log2(self)
		ret=log(self)
		ret=log10(self)
		ret=sin(self)
		ret=cos(self)
		ret=tan(self)
		ret=cot(self)
		ret=sec(self)
		ret=csc(self)
		ret=sind(self)
		ret=cosd(self)
		ret=tand(self)
		ret=cotd(self)
		ret=secd(self)
		ret=cscd(self)
		ret=sinpi(self)
		ret=cospi(self)
		ret=asin(self)
		ret=acos(self)
		ret=atan(self)
		ret=acot(self)
		ret=asec(self)
		ret=acsc(self)
		ret=sinh(self)
		ret=cosh(self)
		ret=tanh(self)
		ret=coth(self)
		ret=sech(self)
		ret=csch(self)
		ret=asinh(self)
		ret=acosh(self)
		ret=atanh(self)
		ret=acoth(self)
		ret=asech(self)
		ret=acsch(self)
		ret=del2(self,h)
		function ret=zsc.del2(self,h)
		%zsc.del2	Discrete Laplacian
		%	ret=zsc.del2(self,h/(h,dims)/*h/**h/mapping(**h))
		%	DNT/zsc.del2 is an alias for DNT/del2.
		%
		%	See also DNT/del2, zsc.del2, del2, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT
			end
			arguments(Input,Repeating)
				h(1,:)
			end
			arguments(Output)
				ret DNT
			end
			ret=del2(self,h{:});
		end
		ret=not(self)
		ret=plus(self,other)
		ret=minus(self,other)
		ret=times(self,other)
		ret=rdivide(self,other)
		ret=ldivide(self,other)
		ret=power(self,other)
		ret=kron(self,other)
		function ret=zsc.kron(self,other)
		%zsc.kron	Kronecker tensor product
		%	ret=zsc.kron(self,other)
		%	DNT/zsc.kron is an alias for DNT/kron.
		%
		%	See also DNT/kron, zsc.kron, kron, DNT

		%	Chris H. Zhao
			arguments(Input)
				self
				other
			end
			arguments(Output)
				ret DNT
			end
			ret=kron(self,other);
		end
		ret=mtimes(self,other)
		ret=mrdivide(self,other)
		ret=mldivide(self,other)
		ret=mpower(self,other)
		ret=mod(self,other)
		ret=rem(self,other)
		ret=idivide(self,other)
		ret=and(self,other)
		ret=or(self,other)
		ret=xor(self,other)
		ret=eq(self,other)
		ret=ne(self,other)
		ret=gt(self,other)
		ret=lt(self,other)
		ret=ge(self,other)
		ret=le(self,other)
		ret=clip(self,lower,upper)
		ret=rescale(self,l,u,options)
		ret=convn(self,other,shape,options)
		ret=fftn(self,sz)
		ret=ifftn(self,sz,symflag)
		ret=horzcat(DNTs)
		ret=vertcat(DNTs)
		ret=cat(dim,DNTs)
		function ret=zsc.cat(dim,DNTs)
		%zsc.cat	Concatenate DNTs
		%	ret=zsc.cat(dim,DNTs)
		%	DNT/zsc.cat is an alias for DNT/cat.
		%
		%	See also DNT/ismember, zsc.ismember, ismember, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				dim(1,:){mustBeA(dim,["logical","numeric","string","char","cell","missing"])}
			end
			arguments(Input,Repeating)
				DNTs DNT
			end
			arguments(Output)
				ret DNT
			end
			ret=cat(dim,DNTs{:});
		end
		ret=sum(self,dims,nanflag)
		ret=cumsum(self,dims,direction,nanflag)
		ret=movsum(self,k,dims,nanflag,options)
		ret=diff(self,n,dims)
		ret=prod(self,dims,nanflag)
		ret=cumprod(self,dims,direction,nanflag)
		ret=movprod(self,k,dims,nanflag,options)
		ret=mean(self,dims,nanflag,options)
		ret=nanmean(self,dims)
		ret=movmean(self,k,dims,nanflag,options)
		ret=median(self,dims,nanflag,options)
		ret=nanmedian(self,dims)
		ret=movmedian(self,k,dims,nanflag,options)
		[ret,F,C]=mode(self,dims)
		ret=mad(self,flag,dims)
		ret=movmad(self,k,dims,nanflag,options)
		[ret,M]=std(self,w,dims,missingflag,options)
		ret=movstd(self,k,w,dims,nanflag,options)
		[ret,M]=var(self,w,dims,nanflag,options)
		ret=movvar(self,k,w,dims,nanflag,options)
		ret=cov(self,other,w,dims,nanflag)
		[ret,P,RL,RU]=corrcoef(self,other,dims,options)
		[ret,lags]=xcov(self,other,dims,maxlag,scaleopt)
		[ret,lags]=xcorr(self,other,dims,maxlag,scaleopt)
		ret=prctile(self,p,dims,options)
		[ret,q]=iqr(self,dims)
		ret=cross(self,other,dim)
		ret=dot(self,other,dims)
		ret=norm(self,p,dims)
		ret=vecnorm(self,p,dims)
		ret=pagenorm(self,p)
		ret=trace(self,dims)
		[ret,ia,ic]=unique(self,dims,setOrder)
		[ret,IA,IC]=uniquetol(self,dims,occurence,options)
		[ret,ia,ib]=union(self,other,dims,setOrder)
		[ret,ia,ib]=intersect(self,other,dims,setOrder)
		[ret,ia]=setdiff(self,other,dims,setOrder)
		[ret,ia,ib]=setxor(self,other,dims,setOrder)
		[ret,Locb]=ismember(self,other,dims)
		function [ret,Locb]=zsc.ismember(self,other,dims)
		%zsc.ismember	True for member of DNT set
		%	[ret,LocB]=zsc.ismember(self,other,
		%	dims=union(self.dimnames,other.dimnames))
		%	DNT/zsc.ismember is an alias for DNT/ismember.
		%
		%	See also DNT/ismember, zsc.ismember, ismember, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT
				other DNT
				dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=union(self.dimnames,other.dimnames)
			end
			arguments(Output)
				ret DNT
				Locb DNT
			end
			[ret,Locb]=ismember(self,other,dims);
		end
		[ret,Locb]=ismembern(self,other,dims)
		[ret,Locb]=ismembertol(self,other,tol,dims,options)
		ret=fft(self,n)
		ret=ifft(self,n)
		ret=fftshift(self,dims)
		ret=ifftshift(self,dims)
		ret=circshift(self,K)
		ret=paddata(self,m,options)
		ret=resize(self,m,options)
		ret=trimdata(self,m,options)
		ret=all(self,dims)
		ret=any(self,dims)
		ret=flip(self,dims)
		ret=conv(self,other,shape,options)
		ret=join(self,delimiter,dims)
		[ret,I]=max(self,other,dims,missingflag,flags,options)
		function [ret,I]=zsc.max(self,other,dims,missingflag,flags,options)
		%zsc.max	Largest component of DNT
		%	[ret,index]=zsc.max(self,[],dims=self.dimnames,
		%	missingflag="omitmissing"[,"linear"],*,ComparisonMethod="auto")
		%	ret=zsc.max(self,other,[],missingflag="omitmissing",*,
		%	ComparisonMethod="auto")
		%	DNT/zsc.max is an alias for DNT/max.
		%
		%	See also DNT/max, zsc.max, max, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self
				other=[]
				dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=ifinline(isequal(other,[]),@()1:ndims(self),@()[])
				missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
			end
			arguments(Input,Repeating)
				flags{mustBeTrue("@(flag)isequal(flag,[])||succeeds(@()assert(startsWith(""linear"",flag)))",flags,VariableNames="flags")}
			end
			arguments(Input)
				options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
			end
			arguments(Output)
				ret DNT
				I DNT
			end
			dstar=dstarclass;
			[ret,I]=max(self,other,dims,missingflag,flags{:},dstar{options});
		end
		[ret,I]=maxk(self,k,dims,options)
		ret=movmax(self,k,dims,nanflag,options)
		ret=cummax(self,dims,direction,nanflag)
		[ret,I]=min(self,other,dims,missingflag,flags,options)
		function [ret,I]=zsc.min(self,other,dims,missingflag,flags,options)
		%zsc.min	Smallest component of DNT
		%	[ret,index]=zsc.min(self,[],dims=self.dimnames,
		%	missingflag="omitmissing"[,"linear"],*,ComparisonMethod="auto")
		%	ret=zsc.min(self,other,[],missingflag="omitmissing",*,
		%	ComparisonMethod="auto")
		%	DNT/zsc.min is an alias for DNT/min.
		%
		%	See also DNT/min, zsc.min, min, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self
				other=[]
				dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=ifinline(isequal(other,[]),@()1:ndims(self),@()[])
				missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
			end
			arguments(Input,Repeating)
				flags{mustBeTrue("@(flag)isequal(flag,[])||succeeds(@()assert(startsWith(""linear"",flag)))",flags,VariableNames="flags")}
			end
			arguments(Input)
				options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
			end
			arguments(Output)
				ret DNT
				I DNT
			end
			dstar=dstarclass;
			[ret,I]=min(self,other,dims,missingflag,flags{:},dstar{options});
		end
		[ret,I]=mink(self,k,dims,options)
		ret=movmin(self,k,dims,nanflag,options)
		ret=cummin(self,dims,direction,nanflag)
		[ret,I]=topkrows(self,k,dims,col,direction,options)
		[ret1,ret2]=bounds(self,dims,missingflag)
		[ret,v]=find(self,n,dims,direction)
		[ret,I]=sort(self,dims,direction,options)
		ret=issorted(self,dims,direction,options)
		[ret,index]=sortrows(self,dims,column,direction,options)
		ret=issortedrows(self,dims,column,direction,options)
		[ret,varargout]=findgroups(DNTs,options)
		% [ret,ID]=findgroups(DNTs,options)
		DNTs=splitapply(f,varargin)
		[DNTs,BG,BC]=groupsummary(DNTs,groupvars,method,options)
		[DNTs,BG]=grouptransform(DNTs,groupvars,method)
		[DNTs,BG]=groupfilter(DNTs,groupvars,method,options)
		[ret,BG,BP]=groupcounts(self,options)
		ret=nnz(self,dims)
		ret=nonzeros(self,n,dims,direction)
		ret=transpose(self,dims,finalize)
		ret=ctranspose(self,dims,finalize)
		ret=pagetranspose(self,finalize)
		ret=pagectranspose(self,finalize)
		ret=permute(self,dims,finalize)
		ret=ipermute(self,dims,finalize)
		[ret,dim,sz]=flatten(self,dims,dim)
		[ret,dims]=unflatten(self,dim,sz,dims)
		ret=reshape(self,sz)
		function ret=zsc.reshape(self,sz)
		%zsc.reshape	Change size of DNT
		%	ret=zsc.reshape(self,sz/(sz,dims)/*sz/**sz/mapping(**sz))
		%	DNT/zsc.reshape is an alias for DNT/reshape.
		%
		%	See also DNT/reshape, zsc.reshape, reshape, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT
			end
			arguments(Input,Repeating)
				sz(1,:)
			end
			arguments(Output)
				ret DNT
			end
			ret=reshape(self,sz{:});
		end
		ret=repmat(self,r)
		function ret=zsc.repmat(self,r)
		%zsc.repmat	Replicate and tile a DNT
		%	ret=zsc.repmat(self,r/(r,dims)/*r/**r/mapping(**r))
		%	DNT/zsc.repmat is an alias for DNT/repmat.
		%
		%	See also DNT/repmat, zsc.repmat, repmat, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				self DNT
			end
			arguments(Input,Repeating)
				r(1,:)
			end
			arguments(Output)
				ret DNT
			end
			ret=reshape(self,r{:});
		end
		ret=repelem(self,r)
		varargout=feval(f,DNTs,options)
		% DNTs=feval(f,DNTs,options)
		function DNTs=zsc.feval(f,DNTs,options)
		%zsc.feval	Eval a function on DNTs with automatic broadcasting
		%	*y=zsc.feval(fun,*x,BroadcastSize=true,AdditionalInput={...})
		%	DNT/zsc.feval is an alias for DNT/feval.
		%
		%	See also DNT/feval, zsc.feval, feval, DNT

		%	Copyright 2025 Chris H. Zhao
			arguments(Input)
				f(1,1)function_handle
			end
			arguments(Input,Repeating)
				DNTs DNT
			end
			arguments(Input)
				options.AdditionalInput(:,1)cell={}
				options.broadcastsize(1,1)logical=true
			end
			arguments(Output,Repeating)
				DNTs DNT
			end
			dstar=dstarclass;
			[tmp{1:nargout}]=feval(f,DNTs{:},dstar{options});
			DNTs=tmp;
		end
		varargout=fevalalong(f,DNTs,options)
		% DNTs=fevalalong(f,DNTs,options)
		varargout=fevalkernel(kernel,kernelind,DNTs,options,indexingoptions,movfunoptions,fevalalongoptions)
		% DNTs=fevalkernel(kernel,kernelind,DNTs,options,indexingoptions,movfunoptions,fevalalongoptions)
		varargout=apply(self,f,AdditionalInput)
		% DNTs=apply(self,f,AdditionalInput)
		varargout=applyalong(self,f,dims,options)
		% DNTs=applyalong(self,f,dims,options)
		varargout=applykernel(self,kernel,kernelsize,options)
		% DNTs=applykernel(self,kernel,kernelsize,options)
		varargout=arrayfun(f,DNTs,options)
		% DNTs=arrayfun(f,DNTs,options)
		varargout=cellfun(f,DNTs,options)
		% DNTs=cellfun(f,DNTs,options)
		varargout=spfun(f,DNTs,options)
		% DNTs=spfun(f,DNTs,options)
		ret=movfun(fun,self,k,dims,options)
		C=bsxfun(fun,A,B)
	end
	methods(Access=protected)
		dispInternal(self,objName,mode)
		% ret=movfunind(SamplePoints,k,Endpoints)
		% subs=parsedimargs(dimnames,dimargs,supportscalar)
		% dims=parsedims(dimnames,dims)
		[self,subs]=parsedimargsindexing(self,subs,mode)
	end
	methods(Access=?dotprivate)
		ret=end_(self,dims,~)
	end
	methods(Static)
		dimname=catdims(dimnames)
		dimnames=splitdim(dimname,n)
		dimnames=gennewdims(dims)
		ret=index(x,y)
	end
	methods(Hidden)
		ret=zerosLike(self,sz)
		ret=onesLike(self,sz)
		ret=nanLike(self,sz)
		ret=infLike(self,sz)
		ret=trueLike(self,sz)
		ret=falseLike(self,sz)
		ret=eyeLike(self,varargin,options)
		ret=randLike(self,varargin)
		ret=randiLike(self,varargin)
		ret=randnLike(self,varargin)
		ret=createArrayLike(~,~,~)
	end
	methods(Static,Hidden)
		ret=empty(varargin,options)
		ret=zeros(varargin)
		ret=ones(varargin)
		ret=nan(varargin)
		ret=inf(varargin)
		ret=true(varargin)
		ret=false(varargin)
		ret=eye(varargin,options)
		ret=rand(varargin)
		ret=randi(varargin)
		ret=randn(varargin)
		ret=createArray(~,~)
	end
end