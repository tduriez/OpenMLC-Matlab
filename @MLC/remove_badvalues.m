function mlc=remove_badvalues(mlc)
%REMOVE_BADVALUES    Hidden Method of the MLC class. Replace useless individuals.
%   MLC_OBJ.REMOVE_BADVALUES can not be called by user. It detects
%   individuals which cost value indicates that they are no use for the MLC
%   process (equal to MLC_OBJ.parameters.badvalue). By emptying their 
%   location in the OBJ.POPULATION.INDIVIDUALS cell and calling 
%   <a href="matlab:help fill_population">fill_population</a> or <a
%   href="matlab:help generate_population">generate_population</a> they are replaced.
%   
%   All options are set in the MLC object (See <a href="matlab:help MLC">MLC</a>). 
%
%   See also MLC, GENERATE_POPULATION, FILL_POPULATION
%
%   Copyright (C) 2016 Thomas Duriez, Steven Brunton, Bernd Noack
%   This file is part of the OpenMLC Toolbox. Distributed under GPL v3.

%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.

verb=mlc.parameters.verbose;
        cgen=length(mlc.population);
        idx=find(mlc.population(cgen).fitnesses==mlc.parameters.badvalue);
        if isempty(idx);
            if verb>1;fprintf('No bad individuals to replace anymore\n');end
            %mlc.parameters.badvalues_elimswitch=1;
            mlc.parameters.elimswitch(1);
        else
            if verb>1;fprintf('%i individuals to replace\n',length(idx));end
            %mlc.parameters.badvalues_elimswitch=0;
            mlc.parameters.elimswitch(0);
            for i=1:length(idx)
                mlc.population(cgen).individuals{idx(i)}=[];
            end
            if cgen==1
                mlc.generate_population;
            else
            mlc.fill_population;
            end
            mlc.evaluate_population('again');
        end
end
                


















































