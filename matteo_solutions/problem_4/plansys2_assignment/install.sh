#!/bin/bash
colcon build --symlink-install --allow-overriding plansys2_assignment
rosdep install --from-paths . --ignore-src -r -y
colcon build --symlink-install --allow-overriding plansys2_assignment

# locate files in the plansys2 folder so that they can be referenced by PATH
if [ -d ~/plansys2_ws/install/plansys2_assignment ]; then
    rm -rf ~/plansys2_ws/install/plansys2_assignment
    echo "Removing previously existing 'install' folder."
fi
cp -RT install/plansys2_assignment ~/plansys2_ws/install/plansys2_assignment

if [ -d ~/plansys2_ws/build/plansys2_assignment ]; then
    rm -rf ~/plansys2_ws/build/plansys2_assignment
    echo "Removing previously existing 'build' folder."
fi
cp -RT build/plansys2_assignment ~/plansys2_ws/build/plansys2_assignment