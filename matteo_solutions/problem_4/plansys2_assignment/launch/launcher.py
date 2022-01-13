# Copyright 2019 Intelligent Robotics Lab
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, SetEnvironmentVariable
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    # Get the launch directory
    example_dir = get_package_share_directory('plansys2_assignment')
    namespace = LaunchConfiguration('namespace')

    declare_namespace_cmd = DeclareLaunchArgument(
        'namespace',
        default_value='',
        description='Namespace')

    stdout_linebuf_envvar = SetEnvironmentVariable(
        'RCUTILS_CONSOLE_STDOUT_LINE_BUFFERED', '1')

    plansys2_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(
            get_package_share_directory('plansys2_bringup'),
            'launch',
            'plansys2_bringup_launch_monolithic.py')),
        launch_arguments={
          'model_file': example_dir + '/pddl/assignment_domain.pddl',
          'namespace': namespace
          }.items())

    # Specify the actions
    back_to_warehouse_cmd = Node(
        package='plansys2_assignment',
        executable='back_to_warehouse_action_node',
        name='back_to_warehouse_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    move_for_delivery_cmd = Node(
        package='plansys2_assignment',
        executable='move_for_delivery_action_node',
        name='move_for_delivery_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    load_cmd = Node(
        package='plansys2_assignment',
        executable='load_action_node',
        name='load_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    unload_cmd = Node(
        package='plansys2_assignment',
        executable='unload_action_node',
        name='unload_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
        
    # Create the launch description and populate
    ld = LaunchDescription()

    # Set environment variables
    ld.add_action(stdout_linebuf_envvar)
    ld.add_action(declare_namespace_cmd)

    # Declare the launch options
    ld.add_action(plansys2_cmd)
    ld.add_action(back_to_warehouse_cmd)
    ld.add_action(move_for_delivery_cmd)
    ld.add_action(load_cmd)
    ld.add_action(unload_cmd)

    return ld
