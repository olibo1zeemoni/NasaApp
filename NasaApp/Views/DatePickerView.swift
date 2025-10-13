//
//  DatePickerView.swift
//  NasaApp
//
//  Created by Olibo moni on 13/10/2025.
//


import SwiftUI

struct DatePickerView: View {
    
    @Binding var selectedDate: Date
    var onDone: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    init(selectedDate: Binding<Date>, onDone: @escaping () -> Void) {
        self._selectedDate = selectedDate
        self.onDone = onDone
    }
    
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2001, month: 01, day: 01)) ?? Date()
        let endDate = Date()
        return startDate...endDate
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Select End Date",
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                
                Spacer()
            }
            .navigationTitle("Select End Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        onDone()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State  var date = Date()
            DatePickerView(selectedDate: $date, onDone: {})
}
