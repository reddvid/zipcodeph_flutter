class AreaRepository {
  List<String> menu(String area) {
    switch (area) {
      case "Metro Manila":
        return [
          "Manila",
          "Caloocan",
          "Las Piñas",
          "Makati",
          "Malabon",
          "Mandaluyong",
          "Marikina",
          "Navotas",
          "Parañaque",
          "Pasay",
          "Pasig",
          "Pateros",
          "Quezon City",
          "San Juan",
          "Taguig",
          "Valenzuela"
        ];
      case "Luzon":
        return [];
      case "Visayas":
        return [];
      case "Minadanao":
        return [];
    }

    return [];
  }
}
