#!/usr/bin/python3
from gi import require_version
require_version('Nautilus', '4.0')
from gi.repository import Nautilus, GObject
import subprocess
import os

class QuickPrintExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        super().__init__()
    
    def get_file_items(self, files):
        # Only show for image files
        if not files:
            return []
        
        for file in files:
            if not file.get_mime_type().startswith('image/'):
                return []
        
        # Create menu item
        item = Nautilus.MenuItem(
            name='QuickPrint::Print',
            label='인쇄',
            tip='이미지 인쇄 대화상자 열기',
            icon='printer'
        )
        item.connect('activate', self.on_print_activate, files)
        
        return [item]
    
    def on_print_activate(self, menu, files):
        # Prepare file paths
        file_paths = '\n'.join([f.get_location().get_path() for f in files])
        
        # Set environment variable and run script
        env = os.environ.copy()
        env['NAUTILUS_SCRIPT_SELECTED_FILE_PATHS'] = file_paths
        
        subprocess.Popen(
            [os.path.expanduser('~/.local/share/nautilus/scripts/.hidden/인쇄')],
            env=env
        )
