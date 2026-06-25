# Butler Startup Flow

## Startup Sequence

1. Verify Termux environment
2. Verify storage permission
3. Verify Termux:X11 package
4. Check if Termux:X11 app is running
5. Start D-Bus
6. Start PulseAudio
7. Verify DISPLAY
8. Launch XFCE
9. Verify desktop session
10. Monitor session health

If any step fails:

- Stop immediately.
- Show the exact reason.
- Suggest a fix.
