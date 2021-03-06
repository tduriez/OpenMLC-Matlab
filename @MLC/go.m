function [mlc] = go(mlc,nb,fig)
%GO    Method of the MLC class. Perform Machine Learning Control until given generation.
%
%   MLC_OBJ.GO(NB) perform Machine Learning Control until generation NB,
%   regardless of the state of MLC_OBJ.
%   MLC_OBJ.GO(NB,FIG) perform Machine Learning Control until generation NB,
%   regardless of the state of MLC_OBJ and displays results in figure FIG.
%
%
%   All options are set in the MLC object (See <a href="matlab:help MLC">MLC</a>). 
%
%   Implemented: - detects the state of MLC_OBJ and performs the next tasks
%                  accordingly until it reaches the evaluation of
%                  generation nb.
%                - saves MLC_OBJ in MAT-files before (mlc_be.mat) and after
%                  (mlc_ae.mat) evaluation.
%                - draws histograms at the end of each generation with 
%                  <a href="matlab:help
%                  show_convergence">show_convergence</a>.
%
%   See also MLC, GENERATE_POPULATION, EVOLVE_POPULATION,
%   EVALUATE_POPULATION, SHOW_CONVERGENCE
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

stop=1;
    if isempty(mlc.population)
        stop=0;
    else
        if length(mlc.population)<nb
            stop=0;
        elseif length(mlc.population)==nb && min(mlc.population(length(mlc.population)).fitnesses)==-1
            stop=0;
        end
    end
         
    while stop==0;
        if isempty(mlc.population)
            mlc.create_script(fullfile(mlc.parameters.savedir,'script.m'));
            %if strcmp(mlc.parameters.selectionmethod,'pareto');mlc.parameters.simplify=1;end
            mlc=mlc.generate_population;
        elseif min(mlc.population(length(mlc.population)).fitnesses)>0
            mlc=mlc.evolve_population;
        end
        if mlc.parameters.save==1;save(fullfile(mlc.parameters.savedir,'mlc_be.mat'),'mlc');end
        eval(mlc.parameters.execute_before_evaluation);
        mlc=mlc.evaluate_population;

        if mlc.parameters.save==1;save(fullfile(mlc.parameters.savedir,'mlc_ae.mat'),'mlc');end
        %mlc.show_convergence(1000,0,100,0,2)
        if nargin>2
        mlc.show_best_indiv;
        %figure(502)
        %mlc.show_stats(0);
        mlc.show_all(fig);
        drawnow
        end
        
        if length(mlc.population)>=nb
            
            stop=1;
        end
    end
   % mlc.parameters.dispswitch=1;
    mlc.parameters.disp_switch(1);
end



















































