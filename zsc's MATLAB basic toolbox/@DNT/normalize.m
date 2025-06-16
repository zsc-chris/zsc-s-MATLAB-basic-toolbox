function [ret,C,S]=normalize(self,dims,varargin)
%NORMALIZE	Normalize data
%	[ret,C,S]=NORMALIZE(self,dims=self.dimnames,
%	method1="zscore"[,methodtype1][,method2][,methodtype2])
%
%	Example:
%	>> [ret,C,S]=NORMALIZE(DNT([1,2;3,10],["a","b"]),"a")
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b               1          2
%	    a
%
%	    1              -0.7071    -0.7071
%	    2               0.7071     0.7071
%
%
%	C =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              2
%	    2              6
%
%
%	S =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1.4142
%	    2              5.6569
%
%	>> [ret,C,S]=NORMALIZE(DNT([1,2;3,10],["a","b"]),2,"scale",DNT([1;5],"a"),"center","mean")
%
%	ret =
%
%	  2×2 DNT double matrix
%
%	         b               1          2
%	    a
%
%	    1              -0.5000     0.5000
%	    2              -0.7000     0.7000
%
%
%	C =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1.5000
%	    2              6.5000
%
%
%	S =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              5
%
%	See also normalize, DNT
%
%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret DNT
		C DNT
		S DNT
	end
	if isempty(varargin)
		varargin={"zscore"};
	end
	varargin(1:2:end)=cellfun(@string,varargin(1:2:end),UniformOutput=false);
	zsc.assert(all(ismember([varargin{1:2:end}],["zscore","norm","scale","range","center","medianiqr"])),message("MATLAB:normalize:InvalidMethod"))
	zsc.assert(numel(varargin)<=2||numel(varargin)<=4&&isequal(sort([varargin{[1,3]}]),["center","scale"]),message("MATLAB:normalize:InvalidDoubleMethod"))
	zsc.assert(varargin{1}~="medianiqr"||isscalar(varargin),message("MATLAB:normalize:IncorrectNumInputsArray"))
	out=outclass;
	switch 4*(varargin{1}=="center")+2*(ismember(varargin{1},["center","scale"])&&~isstring(varargin{2}))+(numel(varargin)>=3&&ismember(varargin{3},["center","scale"])&&~isstring(varargin{4}))
		case {0,4}
			[ret,C,S]=fevalalong(@normalize,dims,self,Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],AdditionalInput=varargin);
		case 1
			C=varargin{4};
			[ret,S]=fevalalong(@(self,methodtype2,dim)out{3,[1,3],@normalize,self,dim,varargin{1:3},methodtype2,varargin{5:end}},dims,self,varargin{4},Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],BroadcastSizeDims="");
		case 2
			S=varargin{2};
			[ret,C]=fevalalong(@(self,methodtype,dim)normalize(self,dim,varargin{1},methodtype,varargin{3:end}),dims,self,varargin{2},Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],BroadcastSizeDims="");
		case 3
			C=varargin{4};
			S=varargin{2};
			ret=fevalalong(@(self,methodtype,methodtype2,dim)normalize(self,dim,varargin{1},methodtype,varargin{3},methodtype2,varargin{5:end}),dims,self,varargin{[2,4]},Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],BroadcastSizeDims="");
		case 5
			S=varargin{4};
			[ret,C]=fevalalong(@(self,methodtype2,dim)normalize(self,dim,varargin{1:3},methodtype2,varargin{5:end}),dims,self,varargin{4},Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],BroadcastSizeDims="");
		case 6
			C=varargin{2};
			[ret,S]=fevalalong(@(self,methodtype,dim)out{3,[1,3],@normalize,self,dim,varargin{1},methodtype,varargin{3:end}},dims,self,varargin{2},Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],BroadcastSizeDims="");
		case 7
			C=varargin{2};
			S=varargin{4};
			ret=fevalalong(@(self,methodtype,methodtype2,dim)normalize(self,dim,varargin{1},methodtype,varargin{3},methodtype2,varargin{5:end}),dims,self,varargin{[2,4]},Mode="flatten",KeepDims=[true,false],Unflatten=[1,0],BroadcastSizeDims="");
	end
end