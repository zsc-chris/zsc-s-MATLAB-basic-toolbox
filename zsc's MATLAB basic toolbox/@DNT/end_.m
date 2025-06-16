function ret=end_(self,dims)
%END_	i.e. self.end is a user-friendly way to call end
%	Since MATLAB end only knows its current position and total subs number, self.end(dims) will help you get the end (number of total indices) for an array of dimensions instead of just one.
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	ret=prod(size(self,dims));
end