function dims=parsedims(dimnames,dims)
%PARSEDIMS	Parse dimensions
%	subs=parsedims(dimnames,dims)

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		dimnames(1,:)string
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}
	end
	arguments(Output)
		dims(1,:)string
	end
	if islogical(dims)
		dims=find(dims);
	end
	if isnumeric(dims)
		dims=string(arrayfun(@(x)ifinline(x<=numel(dimnames),@()dimnames(x),@()dnt.gennewdims(x)),dims));
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)||isa(dims,"missing")
		dims=string(dims);
	end
end