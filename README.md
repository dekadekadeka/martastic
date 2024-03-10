# 💙💛🧡 MARTASTIC 2.0 🧡💛💙
## The wait is over!
Martastic 2.0 offers everything you wanted (and more) from the original Martastic, but in a smaller and more efficient package.

- Rails 7 backend
- Stimulus frontend
- Real-time data from MARTA's official API

### Improvements
- Self-contained in a single Rails app - no more separate frontend and backend repos (and making sure they both get deployed one after the other in completely separate platforms)
- Users can now see only available destination and line options for their selected station; previously, they had to select legal combinations based on their own knowledge of MARTA lines and terminal stations, otherwise showing a "no trains matched your filters" message.
  - While it is still possible to select an illegal combination, it is only possible if selecting a destination or line first and then a station not bound for that destination/on that line; this is easily resolved by selecting "All" for either stations or lines. This is because all available stations must be displayed at all times with no filters, not only as a "reset" option but to be able to select any station currently available. The filter function would otherwise limit a user only to stations on the currently selected destination and/or line, causing potential confusion.
- No more pictures of stations; previously, registered users could add literally any picture by simply submitting the URL with no moderation. This could cause significant problems.
- No more users or user data. It was only added as a previous project requirement to have authentication.
- Filter by waiting time was removed. This is redundant as trains are now sorted by waiting time from the beginning, with trains arriving sooner at the top.
- Entire UI was changed from light to dark, and much more utilitarian and user-friendly than the previous artistic design.
- "After-hours" message that displays when no MARTA trains are running in real life, and when the API is down. Previously, users only saw the "no trains matched your filters" message if there was no data, leading to confusion.

### Instructions
1. Pull down repo
2. Navigate to correct directory `./martastic`
3. Run `rails s`
4. Go to `http://127.0.0.1:3000` on your browser and enjoy!
