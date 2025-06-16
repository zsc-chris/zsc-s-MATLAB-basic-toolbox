function n=numArgumentsFromSubscript(obj,s,indexingContent,options)
%zsc.numArgumentsFromSubscript	Improved version of MATLAB
%numArgumentsFromSubscript
%	n=zsc.numArgumentsFromSubscript(obj,s,indexingContent,*,Size) can get
%	numArgumentsFromSubscript of new object for assignment by setting A to
%	[] and setting a preset size Size, and can tolerate when S is empty.
%
%	See also numArgumentsFromSubscript, zsc.subsasgn

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		obj
		s(1,:)struct
		indexingContent(1,1)matlab.indexing.IndexingContext
		options.Size(1,:)
	end
	if isempty(s)
		n=1;
		return
	end
	if indexingContent==matlab.indexing.IndexingContext.Assignment&&isequal(obj,[])&&isfield(options,"Size")
		switch s(1).type
			case "()"
				if isscalar(s)
					n=1;
				else
					n=numArgumentsFromSubscript(createArray(options.Size,"struct"),s,indexingContent);
				end
			case "{}"
				n=numArgumentsFromSubscript(createArray(options.Size,"cell"),s,indexingContent);
			case "."
				n=numArgumentsFromSubscript(createArray(options.Size,"struct"),s,indexingContent);
		end
	else
		n=numArgumentsFromSubscript(obj,s,indexingContent);
	end
end