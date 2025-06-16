function A=subsasgn(A,S,B,options)
%zsc.subsasgn	Improved version of MATLAB SUBSASGN
%	A=zsc.subsasgn(A,S,*B,Size=[]) can subsasgn new object by setting A to
%	[] (with a preset size Size to tolerate situations like
%	[a{:}]=deal(1)), and can tolerate when S is empty.
%
%	Example:
%	>> subsasgn([],substruct("()",{5}),{1})
%	Error using indexing
%	SUBSASGN must be called with an output.
%
%	>> zsc.subsasgn([],substruct("()",{5}),{1})
%
%	ans =
%
%	  1×5 cell array
%
%	  Columns 1 through 3
%
%	    {0×0 double}    {0×0 double}    {0×0 double}
%
%	  Columns 4 through 5
%
%	    {0×0 double}    {[1]}
%
%	>> zsc.subsasgn([],substruct("()",{5}),{1},Size=[0,1]) % Should be
%	the default behavior of otherwise chaotic evil (the reality) MATLAB
%
%	ans =
%
%	  5×1 cell array
%
%	    {0×0 double}
%	    {0×0 double}
%	    {0×0 double}
%	    {0×0 double}
%	    {[       1]}
%
%	See also subsasgn, zsc.subsref

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		A
		S(1,:)struct
	end
	arguments(Input,Repeating)
		B
	end
	arguments(Input)
		options.Size(1,:)
	end
	if isempty(S)
		A=B{:};
		return
	end
	if isequal(A,[])
		if isfield(options,"Size")
			switch S(1).type
				case "()"
					if isscalar(S)
						A=subsasgn(createArray(options.Size,Like=B{:}),S,B{:});
					else
						A=subsasgn(createArray(options.Size,"struct"),S,B{:});
					end
				case "{}"
					A=subsasgn(createArray(options.Size,"cell"),S,B{:});
				case "."
					A=subsasgn(createArray(options.Size,"struct"),S,B{:});
			end
		else
			if isscalar(S)&&S.type=="()"
				clear A
				A(S.subs{:})=B{:};
			else
				A=subsasgn(A,S,B{:});
			end
		end
	else
		try
			A=subsasgn(A,S,B{:});
		catch ME
			if ME.identifier=="MATLAB:heterogeneousStrucAssignment"
				tmp=zsc.subsref(A,S(1:end-1));
				for i=string(fieldnames(B{:}))'
					if isfield(tmp,i)
						tmp_=arrayfun(@(x){x.(i)},tmp);
					else
						tmp_=arrayfun(@(x){[]},tmp);
					end
					tmp_=subsasgn(tmp_,S(end),arrayfun(@(x){x.(i)},B{:}));
					tmp=paddata(tmp,size(tmp_));
					[tmp.(i)]=tmp_{:};
				end
				A=zsc.subsasgn(A,S(1:end-1),tmp);
			else
				rethrow(ME)
			end
		end
	end
end