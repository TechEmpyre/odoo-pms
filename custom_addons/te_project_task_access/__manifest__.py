# -*- coding: utf-8 -*-
#############################################################################
#
#    TechEmpyre
#
#    Copyright (C) 2026-TODAY TechEmpyre(<https://www.techempyre.com>).
#    Author: TechEmpyre(<https://www.techempyre.com>)
#
#    You can modify it under the terms of the GNU AFFERO
#    GENERAL PUBLIC LICENSE (AGPL v3), Version 3.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU AFFERO GENERAL PUBLIC LICENSE (AGPL v3) for more details.
#
#    You should have received a copy of the GNU AFFERO GENERAL PUBLIC LICENSE
#    (AGPL v3) along with this program.
#    If not, see <http://www.gnu.org/licenses/>.
#
#############################################################################
{
    "name": "Users Restriction For Project And Task",
    "version": "19.0.1.0.0",
    "category": "Project",
    "summary": "Users Restriction For Project And Task restricts and access "
    "the users to the project and task records.",
    "description": """The 'Users Restriction For Project And Task' is a system 
    designed to specify and control which individuals or roles within an 
    organization have permission to view or interact with project and task 
    records. It ensures that only authorized users can access and manage 
    sensitive project and task-related information, enhancing security and 
    privacy within the organization's data management processes""",
    "author": "TechEmpyre",
    "company": "TechEmpyre",
    "maintainer": "TechEmpyre",
    "website": "https://www.techempyre.com",
    "depends": ["project"],
    "data": [
        "security/project_task_security.xml",
        "views/project_project_views.xml",
        "views/project_task_views.xml",
    ],
    "images": ["static/description/banner.jpg"],
    "license": "AGPL-3",
    "installable": True,
    "auto_install": False,
    "application": False,
}
