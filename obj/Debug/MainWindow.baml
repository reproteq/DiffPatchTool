   M S B A M L   `   `   `  ����H  DDiffPatchTool, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:DiffPatchToolDiffPatchTool  5   	       DiffPatchTool.MainWindow   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:DiffPatchTool     5   	     � Title$  DiffPatchTool v1��5   	   $	��480��6"   $	��392��6/    � 
ResizeMode$ NoResize=�6;   .��5	      � $��0,0,0,0q�6    � ColumnDefinitions 5
   
   �� 5      $��* �6   .+�5   
   ]� $��0,0,0,0q�6   .+�5      o� $	��Top=�6   .@�5      m� $��_Menu��6   .@�5      m� -   5        $��_About��5      6/   �� 5      m� 5      -   5        $��_Exit��5      6.   5      5      5      �� 5   
   -   5         ��Name$ 	labelSoft��5      $��Copyright 2021 Reproteq®��6#   $��123,421,104.667,0q�6F   $��9(�6a   $��27��6n   $	��Top=�6z   �� 5   
   ���	#FFF4F4F5$��10,264,9.667,27q�6%   
���   �6>   �� 5   
   ���	#FFF4F4F5$��71��6%   $��10,121,9.667,0q�61   
���   �$	��Top=�6X   �� 5!   
   ���	#FFF4F4F5$��71��6%   $��10,32,9.667,0q�61   
���   �$	��Top=�6W   �� 5$   
   -   5        $��Scroller��5$      $��15,270,12.667,38q�6(   $��Visible=�6B   $
��Auto=�6h   .��5%      �� -   5        $��OutputBlock��5%      $��Consolas)�6,    �� Padding$ 4q�6B   $��9(�6O   $
��Wrap=�6\   5&      �� 5(   
   -   5        $��Label1��5(      $��File1 Ori.bin��6   $	��Top=�66   $
��Left=�6N   $	��135��6i   $��26��6u   $��
104,32,0,0q�6�   �� 5)   
   -   5        $��Label2��5)      $��File2 Mod.bin / Patch.txt��6   $
��Left=�6B   $��104,123,0,0q�6]   $	��Top=�6r   $��26��6�   $	��161��6�   �� 5*   
   -   5        $��btnFile1��5*      $��File1��6!   $��19,42,294.667,0q�61   $	��Top=�6J   $��51��6b   $��Segoe UI Semibold)�6�   $��20(�6�   �� 5+   
   -	   5        $��btnFile2��5+      $��File2��6!   $��19,131,294.667,0q�61   $	��Top=�6K   $��51��6c   $��Segoe UI Semibold)�6�   $��20(�6�   �� 5,   
   -
   5        $��btnDiff��5,      $
��DIFF��6    $��10,197,203.667,193q�6/   $��36(�6a   $��Segoe UI Black)�6o   �� 5-   
   -   5        $��btnPatch��5-      $��PATCH��6!   $��203,197,9.667,193q�61   $��Segoe UI Black)�6c   $��36(�6   �� 5.   
   -   5        $��	tboxFile1��5.      $��20��6#    �� TextWrapping$
 Wrap=�6/   $�� ��6C   $	��Top=�6K   $��109,58,27.667,0q�6c   �� 5/   
   -   5        $��	tboxFile2��5/      $��20��6#   $��109,149,27.667,0q�6/   $
 Wrap=�6I   $�� ��6]   $	��Top=�6e   53      54      