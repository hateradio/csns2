/*
 * This file is part of the CSNetwork Services (CSNS) project.
 * 
 * Copyright 2012, Chengyu Sun (csun@calstatela.edu).
 * 
 * CSNS is free software: you can redistribute it and/or modify it under the
 * terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 * 
 * CSNS is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 * 
 * You should have received a copy of the GNU Affero General Public License
 * along with CSNS. If not, see http://www.gnu.org/licenses/agpl.html.
 */
package csns.model.academics.dao;

import java.util.List;

import csns.model.academics.Assignment;
import csns.model.academics.OnlineAssignment;
import csns.model.academics.Section;
import csns.model.core.User;

public interface AssignmentDao {

    Assignment getAssignment( Long id );

    List<Assignment> searchAssignments( String term, String type,
        User instructor, int maxResults );

    List<OnlineAssignment> getOnlineAssignments( Section section );

    List<OnlineAssignment> getOnlineAssignments( User instructor );

    Assignment saveAssignment( Assignment assignment );

}
