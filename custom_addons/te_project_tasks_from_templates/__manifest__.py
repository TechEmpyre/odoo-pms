# -*- coding: utf-8 -*-
###############################################################################
#
#    TechEmpyre
#
#    Copyright (C) 2026-TODAY TechEmpyre(<https://www.techempyre.com>)
#    Author: TechEmpyre (contact@techempyre.com)
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
###############################################################################
{
    'name': 'Project Templates',
    'version': '19.0.1.0.0',
    'category': "Project",
    'summary': "This app allows your project team to create project"
               "template and task template",
    'description': "When faced with the need to create multiple projects that "
                   "share similar tasks, manually inputting data such as task "
                   "names, descriptions, and assigned individuals can be "
                   "time-consuming. In such situations, this module offers "
                   "assistance in creating and managing projects based on "
                   "pre-defined templates.",
    'author': 'TechEmpyre',
    'company': 'TechEmpyre',
    'maintainer': 'TechEmpyre',
    'website': "https://www.techempyre.com",
    'depends': ['project'],
    'data': [
        'security/ir.model.access.csv',
        'views/project_project_views.xml',
        'views/project_sub_task_views.xml',
        'views/project_stage_views.xml',
        'views/project_task_template_views.xml'
    ],
    'images': ['static/description/banner.jpg'],
    'license': 'AGPL-3',
    'installable': True,
    'auto_install': False,
    'application': False,
}
